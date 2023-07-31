//
//  File.swift
//  
//
//  Created by Felix Fischer on 28/07/2023.
//

import Foundation

enum TakeError: Error {
    case filesNotUploaded
}

public actor Take {
    @Dependency private var graphQLClient: GraphQLClient

    var id: String = UUID().uuidString // This ID will change when we create a take as we then use the remote takeID
    var numberOfRetakes: Int = 0
    var videoFile: File
    var moveFile: File
    private var jobs: [Job] = [] // last job is the current job

    var uploaded: Bool {
        get async {
            let videoFileRemoteId = await videoFile.remoteID
            let moveFileRemoteId = await moveFile.remoteID
            return videoFileRemoteId != nil && moveFileRemoteId != nil
        }
    }

    var currentJob: Job? {
        return jobs.last
    }

    var description: String {
        get async {
            var string = "\(id)\n\(numberOfRetakes)\n\(videoFile)\n\(moveFile)\n"
            for job in jobs {
                string.append(await job.description + "\n")
            }
            return string
        }
    }

    init(videoFile: File, moveFile: File) {
        self.videoFile = videoFile
        self.moveFile = moveFile
    }

    func upload() async throws {
        try await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask { try await self.videoFile.upload() }
            group.addTask { try await self.moveFile.upload() }

            try await group.waitForAll()
        }
        guard let videoFileID = await videoFile.remoteID, let moveFileID = await moveFile.remoteID else {
            throw TakeError.filesNotUploaded
        }
        let takeResult = try await graphQLClient.createTake(videoFileId: videoFileID, moveFileId: moveFileID)
        id = takeResult.id

    }

    func newJob() async throws {
        let jobResult = try await graphQLClient.createJob(takeId: id)
        let job = Job(id: jobResult.id)
        jobs.append(job)
    }
}


