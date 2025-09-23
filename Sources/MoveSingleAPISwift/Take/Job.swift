//
//  Job.swift
//  
//
//  Created by Felix Fischer on 31/07/2023.
//

import Foundation
import Apollo

extension GraphQLError {
    func asJobError() -> JobError? {
        JobError(code: self["errorType"] as? String ?? "",
                 message: self.message ?? "",
                 suggestions: (self["errorInfo"] as? [String: Any])?["suggestions"]  as? [String] ?? [],
                 takeID: ((self["errorInfo"] as? [String: Any])?["data"] as? [String: Any])?["takeId"] as? String ?? "",
                 jobID: ((self["errorInfo"] as? [String: Any])?["data"] as? [String: Any])?["id"] as? String ?? "",
                 tenantID: ((self["errorInfo"] as? [String: Any])?["data"] as? [String: Any])?["tenant_id"] as? String ?? "",
                 clientID: ((self["errorInfo"] as? [String: Any])?["data"] as? [String: Any])?["client_id"] as? String ?? "")

    }
}

public struct JobError: Equatable, Hashable, Identifiable {
    public var id: String {
        code
    }
    
    public var code: String
    public var message: String
    public var suggestions: [String]

    public var takeID: String
    public var jobID: String
    public var tenantID: String
    public var clientID: String

    static let sample = JobError(code: "MV_060_240_0999",
                                 message: "The engine hasn't been able to identify an actor",
                                 suggestions: ["Please check one actor is fully visible in the video."],
                                 takeID: "take-c46f559f-83ad-4780-9354-213d65895365",
                                 jobID: "job-2f56d0aa-879c-446c-9ee0-dec36d4bdbda",
                                 tenantID: "tenant_19aac7a1-7fe9-45cf-aca6-c3ab9cec5a29",
                                 clientID: "client-2ef39418-2236-40a8-92dc-d4fc95622e68")
}


public actor Job {

    public enum Status: String, Codable {
        case notStarted = "NOT STARTED"
        case started = "RUNNING"
        case failed = "FAILED"
        case finished = "FINISHED"
        case unknown

        init(from: String?) {
            if let from = from {
                self = .init(rawValue: from) ?? .unknown
            } else {
                self = .unknown
            }
        }
    }
    
    public typealias Metadata = [String: AnyHashable]

    @Dependency private var graphQLClient: GraphQLClient

    public let id: String
    public var state: Status
    public var outputFiles: [FileType: File]
    public var metadata: Metadata?

    //public var errors: [GraphQLError] = []
    public var errors: [JobError] = []
    var description: String {
        "Job(id: \(id), state: \(state), outputFiles: \(outputFiles)), metadata: \(metadata?.toJSONString() ?? "NA")"
    }

    var codable: CodableJob {
        get async {
            var codableFiles: [FileType: File.CodableFile] = [:]
            for file in outputFiles {
                codableFiles[file.key] = await file.value.codable
            }
            return CodableJob(id: id, state: state, outputFiles: codableFiles, metadata: metadata?.toJSONString())
        }
    }

    public init(id: String, state: Status = .unknown, outputFiles: [FileType: File] = [:], metadata: [String: AnyHashable]? = nil) {
        self.id = id
        self.state = state
        self.outputFiles = outputFiles
        self.metadata = metadata
    }

    public init(from: CodableJob) {
        self.id = from.id
        self.state = from.state

        var files: [FileType: File] = [:]
        for file in from.outputFiles {
            files[file.key] = File(from: file.value)
        }

        self.outputFiles = files
        self.metadata = Dictionary<String, AnyHashable>.convertStringToDictionary(from.metadata)
    }

    // here
    public func update() async throws {
        let jobResultPair = try await graphQLClient.getJob(id: id)
        let jobResult = jobResultPair.0
        let jobErrors = jobResultPair.1
        state = Status(from: jobResult.state)
        errors = jobErrors?.compactMap { $0.asJobError() } ?? []

        if state == .finished {
            var files: [FileType: File] = [:]
            for output in jobResult.outputs ?? [] {
                if let output = output, let key = output.key,
                   let type = FileType(from: key) {
                    let file = File(type: type, remoteID: output.file.id)
                    files[type] = file
                }
            }
            outputFiles = files
        }
    }

    public struct CodableJob: Codable {
        let id: String
        let state: Status
        let outputFiles: [FileType: File.CodableFile]
        let metadata: String?
    }
}
