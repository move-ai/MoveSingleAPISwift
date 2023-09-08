//
//  TakeTests.swift
//  
//
//  Created by Felix Fischer on 31/07/2023.
//

import XCTest
@testable import MoveSingleAPISwift

final class TakeTests: XCTestCase {

    override func setUpWithError() throws {
        DependencyContainer.register(GraphQLClientMock() as GraphQLClient)
        DependencyContainer.register(URLSessionClientMock() as URLSessionClient)
        DependencyContainer.register(FileStorageClientMock() as FileStorageClient)
    }

    func testUpload() async throws {
        let videoFile = MoveSingleAPISwift.File(type: .video, localFileName: "ABC")
        let moveFile = MoveSingleAPISwift.File(type: .move, localFileName: "ABC")
        let take = MoveSingleAPISwift.Take(takeID: UUID().uuidString, videoFile: videoFile, moveFile: moveFile, metadata: TakeMetadata(camera: .front, rotated: true))
        let oldTakeID = await take.takeID
        try await take.upload()
        let uploaded = await take.uploaded
        let newTakeID = await take.takeID

        XCTAssert(uploaded)
        XCTAssert(oldTakeID != newTakeID)
    }

    func testAddOneJob() async throws {
        let videoFile = MoveSingleAPISwift.File(type: .video)
        let moveFile = MoveSingleAPISwift.File(type: .move)
        let take = MoveSingleAPISwift.Take(takeID: UUID().uuidString, videoFile: videoFile, moveFile: moveFile, metadata: TakeMetadata(camera: .front, rotated: true))
        await XCTAssertNilAsync(await take.currentJob)
        try await take.createJob()
        await XCTAssertNotNilAsync(await take.currentJob)
    }

    func testAddTwoJobs() async throws {
        let videoFile = MoveSingleAPISwift.File(type: .video)
        let moveFile = MoveSingleAPISwift.File(type: .move)
        let take = MoveSingleAPISwift.Take(takeID: UUID().uuidString, videoFile: videoFile, moveFile: moveFile, metadata: TakeMetadata(camera: .front, rotated: true))

        try await take.createJob()
        let firstJobID = await take.currentJob?.id
        XCTAssertNotNil(firstJobID)

        try await take.createJob()
        let secondJobID = await take.currentJob?.id
        XCTAssertNotNil(secondJobID)

        XCTAssertNotEqual(firstJobID, secondJobID)
    }

}
