//
//  ProtobufGeneratorIntrinsicsTests.swift
//  
//
//  Created by Felix Fischer on 02/08/2023.
//

import XCTest
@testable import MoveSingleAPISwift

final class ProtobufGeneratorIntrinsicsTests: XCTestCase {

    func testIntrinsics() {
        let cameraDesignData = CameraDesignData(from: .mock)
        let intrinsics = ProtobufGenerator.intrinsic(from: cameraDesignData)
        XCTAssertEqual(intrinsics.centerPointX, 7)
        XCTAssertEqual(intrinsics.centerPointY, 8)
        XCTAssertEqual(intrinsics.focalLengthX, 1)
        XCTAssertEqual(intrinsics.focalLengthY, 5)
        XCTAssertEqual(intrinsics.skew, 2)
        XCTAssertEqual(intrinsics.resolution.width, 100)
        XCTAssertEqual(intrinsics.resolution.height, 100)
    }

}
