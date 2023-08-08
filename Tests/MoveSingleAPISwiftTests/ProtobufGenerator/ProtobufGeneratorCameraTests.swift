//
//  ProtobufGeneratorCameraTests.swift
//  
//
//  Created by Felix Fischer on 03/08/2023.
//

import XCTest
@testable import MoveSingleAPISwift

final class ProtobufGeneratorCameraTests: XCTestCase {
    func testCameraWithoutAnything() {
        let enhancementData = EnhancementData(cameraDesignData: nil, cameraPositionData: nil, depthSensorData: nil)
        let camera = ProtobufGenerator.camera(from: enhancementData, config: .default)
        XCTAssertEqual(camera.name, "iPhoneFrontRGB")
        XCTAssertFalse(camera.hasIntrinsics)
        XCTAssertFalse(camera.hasExtrinsics)
    }

    func testCameraWithoutDepth() {
        let cameraDesignData = CameraDesignData(from: .mock)
        let enhancementData = EnhancementData(cameraDesignData: cameraDesignData, cameraPositionData: nil, depthSensorData: nil)
        let camera = ProtobufGenerator.camera(from: enhancementData, config: .default)
        XCTAssertEqual(camera.name, "iPhoneFrontRGB")
        XCTAssertTrue(camera.hasIntrinsics)
        XCTAssertFalse(camera.hasExtrinsics)
    }
}
