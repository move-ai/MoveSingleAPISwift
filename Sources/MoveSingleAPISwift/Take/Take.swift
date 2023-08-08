//
//  File.swift
//  
//
//  Created by Felix Fischer on 28/07/2023.
//

import Foundation
import Zip

enum TakeError: Error {
    case filesNotUploaded
}

public actor Take: Identifiable {
    @Dependency private var graphQLClient: GraphQLClient

    public let id: String // needed to be Identifiable
    public var takeID: String // This ID will change when we create a take as we then use the remote takeID
    public var numberOfRetakes: Int = 0
    public var videoFile: File
    public var moveFile: File
    private var jobs: [Job] = [] // last job is the current job

    var uploaded: Bool {
        get async {
            let videoFileRemoteId = await videoFile.remoteID
            let moveFileRemoteId = await moveFile.remoteID
            return videoFileRemoteId != nil && moveFileRemoteId != nil
        }
    }

    public var currentJob: Job? {
        return jobs.last
    }

    var description: String {
        get async {
            var string = "\(takeID)\n\(numberOfRetakes)\n\(videoFile)\n\(moveFile)\n"
            for job in jobs {
                string.append(await job.description + "\n")
            }
            return string
        }
    }

    public var info: String {
        get async {
            return """
            ID: \(takeID)
            numberOfRetakes: \(numberOfRetakes)
            videoRemoteID: \(await videoFile.remoteID ?? "NA")
            moveRemoteID: \(await moveFile.remoteID ?? "NA")
            jobRemoteID: \(currentJob?.id ?? "NA")
            jobState: \(await currentJob?.state.rawValue ?? "NA")
            """
        }
    }

    public var codable: CodableTake {
        get async {
            var codableJobs: [Job.CodableJob] = []
            for job in jobs {
                codableJobs.append(await job.codable)
            }

            return CodableTake(
                id: takeID,
                numberOfRetakes: numberOfRetakes,
                videoFile: await videoFile.codable,
                moveFile: await moveFile.codable,
                jobs: codableJobs
            )
        }
    }

    public init(takeID: String, videoFile: File, moveFile: File) {
        self.id = takeID
        self.takeID = takeID
        self.videoFile = videoFile
        self.moveFile = moveFile
    }

    public init(from: CodableTake) {
        self.id = from.id
        self.takeID = from.id
        self.numberOfRetakes = from.numberOfRetakes
        self.videoFile = File(from: from.videoFile)
        self.moveFile = File(from: from.moveFile)
        self.jobs = from.jobs.map { Job(from: $0) }
    }

    public func upload() async throws {
        try await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask { try await self.videoFile.upload() }
            group.addTask { try await self.moveFile.upload() }

            try await group.waitForAll()
        }
        guard let videoFileID = await videoFile.remoteID, let moveFileID = await moveFile.remoteID else {
            throw TakeError.filesNotUploaded
        }
        let takeResult = try await graphQLClient.createTake(videoFileId: videoFileID, moveFileId: moveFileID)
        takeID = takeResult.id

    }

    public func newJob() async throws {
        let jobResult = try await graphQLClient.createJob(takeId: takeID)
        let job = Job(id: jobResult.id)
        jobs.append(job)
    }

    public func zip() async throws -> URL {
        var filesToZip = [
            await videoFile.localUrl,
            await moveFile.localUrl,
        ]
        for outputFile in await currentJob?.outputFiles ?? [:] {
            filesToZip.append(await outputFile.value.localUrl)
        }
        let exportZipURL = try await Task { try Zip.quickZipFiles(filesToZip.compactMap { $0 }, fileName: takeID) }.value
        return exportZipURL
    }

    public struct CodableTake: Codable {
        let id: String
        let numberOfRetakes: Int
        let videoFile: File.CodableFile
        let moveFile: File.CodableFile
        let jobs: [Job.CodableJob]
    }
}


