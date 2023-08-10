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

    @Dependency private var graphQLClient: GraphQLClient

    public let id: String
    public var state: Status = .notStarted
    public var outputFiles: [FileType: File] = [:]

    var description: String {
        "Job(id: \(id), state: \(state), outputFiles: \(outputFiles))"
    }

    var codable: CodableJob {
        get async {
            var codableFiles: [FileType: File.CodableFile] = [:]
            for file in outputFiles {
                codableFiles[file.key] = await file.value.codable
            }
            return CodableJob(id: id, state: state, outputFiles: codableFiles)
        }
    }

    init(id: String) {
        self.id = id
    }

    public init(from: CodableJob) {
        self.id = from.id
        self.state = from.state

        var files: [FileType: File] = [:]
        for file in from.outputFiles {
            files[file.key] = File(from: file.value)
        }

        self.outputFiles = files
    }

    public func update() async throws {
        let jobResult = try await graphQLClient.getJob(id: id)
        state = Status(from: jobResult.state)
        if state == .finished {
            var files: [FileType: File] = [:]
            for output in jobResult.outputs ?? [] {
                if let output = output,
                   let type = FileType(from: output.key) {
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
    }
}
