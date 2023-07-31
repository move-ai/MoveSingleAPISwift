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
    }

    func testUpload() async throws {
        let videoFile = File(type: .video, localUrl: URL(string: "http://www.move.ai")!)
        let moveFile = File(type: .move, localUrl: URL(string: "http://www.move.ai")!)
        let take = Take(videoFile: videoFile, moveFile: moveFile)
        let oldTakeID = await take.id
        try await take.upload()
        let uploaded = await take.uploaded
        let newTakeID = await take.id

        XCTAssert(uploaded)
        XCTAssert(oldTakeID != newTakeID)
    }

    func testAddOneJob() async throws {
        let videoFile = File(type: .video)
        let moveFile = File(type: .move)
        let take = Take(videoFile: videoFile, moveFile: moveFile)
        await XCTAssertNilAsync(await take.currentJob)
        try await take.newJob()
        await XCTAssertNotNilAsync(await take.currentJob)
    }

    func testAddTwoJobs() async throws {
        let videoFile = File(type: .video)
        let moveFile = File(type: .move)
        let take = Take(videoFile: videoFile, moveFile: moveFile)

        try await take.newJob()
        let firstJobID = await take.currentJob?.id
        XCTAssertNotNil(firstJobID)

        try await take.newJob()
        let secondJobID = await take.currentJob?.id
        XCTAssertNotNil(secondJobID)

        XCTAssertNotEqual(firstJobID, secondJobID)
    }

}
