//
//  Job.swift
//  
//
//  Created by Felix Fischer on 31/07/2023.
//

import Foundation

actor Job {
    enum Status: String {
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

    let id: String
    var state: Status = .notStarted
    var outputFiles: [File] = []

    var description: String {
        "Job(id: \(id), state: \(state), outputFiles: \(outputFiles))"
    }

    init(id: String) {
        self.id = id
    }

    func update() async throws {
        let jobResult = try await graphQLClient.getJob(id: id)
        state = Status(from: jobResult.state)
        if state == .finished {
            let files = jobResult.outputs?.compactMap { output -> File? in
                guard let output = output,
                      let type = FileType(rawValue: output.key) else { return nil }
                return File(type: type, remoteID: output.file.id)
            }
            outputFiles = files ?? []
        }
    }
}
