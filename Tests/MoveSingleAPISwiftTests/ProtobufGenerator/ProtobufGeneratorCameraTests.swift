//
//  ProtobufGeneratorCameraTests.swift
//  
//
//  Created by Felix Fischer on 03/08/2023.
//

import XCTest
@testable import MoveSingleAPISwift

final class ProtobufGeneratorCameraTests: XCTestCase {

    func testCameraWithoutDepth() {
        let camera = ProtobufGenerator.camera(from: .mock, config: .default)
        XCTAssertEqual(camera.name, "iPhoneFrontRGB")
        XCTAssertTrue(camera.hasIntrinsics)
        XCTAssertFalse(camera.hasExtrinsics)
    }
}
