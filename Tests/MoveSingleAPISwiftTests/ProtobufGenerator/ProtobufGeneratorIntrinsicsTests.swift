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
        let instrinsics = ProtobufGenerator.intrinsic(from: .mock)
        XCTAssertEqual(instrinsics.centerPointX, 7)
        XCTAssertEqual(instrinsics.centerPointY, 8)
        XCTAssertEqual(instrinsics.focalLengthX, 1)
        XCTAssertEqual(instrinsics.focalLengthY, 5)
        XCTAssertEqual(instrinsics.skew, 2)
        XCTAssertEqual(instrinsics.resolution.width, 100)
        XCTAssertEqual(instrinsics.resolution.height, 100)
    }

}
