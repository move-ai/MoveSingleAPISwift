//
//  Job.swift
//  
//
//  Created by Felix Fischer on 31/07/2023.
//

import Foundation

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

    public func update() async throws {
        let jobResult = try await graphQLClient.getJob(id: id)
        state = Status(from: jobResult.state)
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
