//
//  ProtobufGeneratorGenerateTests.swift
//  
//
//  Created by Felix Fischer on 04/08/2023.
//

import XCTest
@testable import MoveSingleAPISwift

final class ProtobufGeneratorGenerateTests: XCTestCase {

    func testGenerateNoEnhancement() async throws {
        let enhancementData = EnhancementData(cameraDesignData: nil, cameraPositionData: nil, depthSensorData: nil)
        let data = try await ProtobufGenerator.generate(from: [enhancementData], config: .default)
        XCTAssertEqual(data.count, 24)
    }

    func testGenerateWithCamera() async throws {
        let cameraDesignData = CameraDesignData(from: .mock)
        let enhancementData = EnhancementData(cameraDesignData: cameraDesignData, cameraPositionData: nil, depthSensorData: nil)
        let data = try await ProtobufGenerator.generate(from: [enhancementData], config: .default)
        XCTAssertEqual(data.count, 57)
    }

    func testGenerateWithIMU() async throws {
        let enhancementData = EnhancementData(cameraDesignData: nil, cameraPositionData: .mock, depthSensorData: nil)
        let data = try await ProtobufGenerator.generate(from: [enhancementData], config: .default)
        XCTAssertEqual(data.count, 86)
    }

    func testGenerateWithCameraAndIMU() async throws {
        let cameraDesignData = CameraDesignData(from: .mock)
        let enhancementData = EnhancementData(cameraDesignData: cameraDesignData, cameraPositionData: .mock, depthSensorData: nil)
        let data = try await ProtobufGenerator.generate(from: [enhancementData], config: .default)
        XCTAssertEqual(data.count, 119)
    }

}
