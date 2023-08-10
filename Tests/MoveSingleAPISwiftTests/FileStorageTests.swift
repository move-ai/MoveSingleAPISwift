//
//  FileStorageTests.swift
//  
//
//  Created by Move.ai on 04/08/2023.
//

import XCTest
import AVFoundation
@testable import MoveSingleAPISwift

final class FileStorageTests: XCTestCase {

	func testSaveMoveData() async throws {
        let enhancementData = EnhancementData(cameraDesignData: nil, cameraPositionData: nil, depthSensorData: nil)
        let data = try await ProtobufGenerator.generate(from: [enhancementData], config: .default)
		let moveFileName = try await FileStorageClientImpl().saveMove(data)
        let moveFileURL = URL.documentsDirectory.appending(path: "\(moveFileName).move")
		XCTAssertTrue(FileManager.default.fileExists(atPath: moveFileURL.path()))
	}
}
