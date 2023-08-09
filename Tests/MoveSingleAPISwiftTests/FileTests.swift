//
//  FileTests.swift
//  
//
//  Created by Felix Fischer on 31/07/2023.
//

import XCTest
@testable import MoveSingleAPISwift

final class FileTests: XCTestCase {

    override func setUpWithError() throws {
        DependencyContainer.register(GraphQLClientMock() as GraphQLClient)
        DependencyContainer.register(URLSessionClientMock() as URLSessionClient)
        DependencyContainer.register(FileStorageClientMock() as FileStorageClient)
    }

    func testUploadSuccess() async throws {
        let file = File(type: .video, localFileName: "ABC")
        await XCTAssertNilAsync(await file.remoteID)
        try await file.upload()
        await XCTAssertNotNilAsync(await file.remoteID)
    }

    func testDownloadSuccess() async throws {
        let file = File(type: .video, remoteID: UUID().uuidString)
        await XCTAssertNilAsync(await file.localUrl)
        try await file.download()
        await XCTAssertNotNilAsync(await file.localUrl)
    }

    func testUploadMalformedPresignedUrl() async throws {
        DependencyContainer.register(GraphQLClientMock(presignedUrl: "") as GraphQLClient)

        let file = File(type: .video, localFileName: "ABC")
        await XCTAssertNilAsync(await file.remoteID)
        await XCTAssertThrowsError(try await file.upload())
        await XCTAssertNilAsync(await file.remoteID)
    }

    func testDownloadMalformedPresignedUrl() async throws {
        DependencyContainer.register(GraphQLClientMock(presignedUrl: "") as GraphQLClient)

        let file = File(type: .video, remoteID: UUID().uuidString)
        await XCTAssertNilAsync(await file.localUrl)
        await XCTAssertThrowsError(try await file.download())
        await XCTAssertNilAsync(await file.localUrl)
    }

    func testUploadMissingLocalUrl() async throws {
        let file = File(type: .video)
        await XCTAssertNilAsync(await file.remoteID)
        await XCTAssertThrowsError(try await file.upload())
        await XCTAssertNilAsync(await file.remoteID)
    }

    func testDownloadMissingRemoteId() async throws {
        let file = File(type: .video)
        await XCTAssertNilAsync(await file.localUrl)
        await XCTAssertThrowsError(try await file.download())
        await XCTAssertNilAsync(await file.localUrl)
    }

}
