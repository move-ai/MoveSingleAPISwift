//
//  JobTests.swift
//  
//
//  Created by Felix Fischer on 31/07/2023.
//

import XCTest
@testable import MoveSingleAPISwift

final class JobTests: XCTestCase {

    func testUpdateNotStarted() async throws {
        DependencyContainer.register(GraphQLClientMock(jobState: "NOT STARTED") as GraphQLClient)
        let job = MoveSingleAPISwift.Job(id: UUID().uuidString)
        let oldState = await job.state
        XCTAssertEqual(oldState, .notStarted)
        try await job.update()
        let newState = await job.state
        XCTAssertEqual(newState, .notStarted)
    }

    func testUpdateRunning() async throws {
        DependencyContainer.register(GraphQLClientMock(jobState: "RUNNING") as GraphQLClient)
        let job = MoveSingleAPISwift.Job(id: UUID().uuidString)
        let oldState = await job.state
        XCTAssertEqual(oldState, .notStarted)
        try await job.update()
        let newState = await job.state
        XCTAssertEqual(newState, .started)
    }

    func testUpdateFailed() async throws {
        DependencyContainer.register(GraphQLClientMock(jobState: "FAILED") as GraphQLClient)
        let job = MoveSingleAPISwift.Job(id: UUID().uuidString)
        let oldState = await job.state
        XCTAssertEqual(oldState, .notStarted)
        try await job.update()
        let newState = await job.state
        XCTAssertEqual(newState, .failed)
    }

    func testUpdateFinished() async throws {
        DependencyContainer.register(GraphQLClientMock(jobState: "FINISHED") as GraphQLClient)
        let job = MoveSingleAPISwift.Job(id: UUID().uuidString)
        let oldState = await job.state
        XCTAssertEqual(oldState, .notStarted)
        try await job.update()
        let newState = await job.state
        XCTAssertEqual(newState, .finished)
    }

    func testUpdateUnknown() async throws {
        DependencyContainer.register(GraphQLClientMock(jobState: "NOT YET DEFINED") as GraphQLClient)
        let job = MoveSingleAPISwift.Job(id: UUID().uuidString)
        let oldState = await job.state
        XCTAssertEqual(oldState, .notStarted)
        try await job.update()
        let newState = await job.state
        XCTAssertEqual(newState, .unknown)
    }

    func testDownloadOutputFiles() async throws {
        DependencyContainer.register(GraphQLClientMock(jobState: "FINISHED") as GraphQLClient)
        DependencyContainer.register(URLSessionClientMock() as URLSessionClient)
        
        let job = MoveSingleAPISwift.Job(id: UUID().uuidString)
        var jobCount = await job.outputFiles.count
        XCTAssertEqual(jobCount, 0)
        try await job.update()
        let newState = await job.state
        XCTAssertEqual(newState, .finished)
        jobCount = await job.outputFiles.count
        XCTAssertEqual(jobCount, 1)
    }

}
