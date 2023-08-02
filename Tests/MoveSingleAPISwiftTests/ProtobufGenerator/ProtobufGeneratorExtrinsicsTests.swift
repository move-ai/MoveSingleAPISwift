//
//  ProtobufGeneratorExtrinsicsTests.swift
//  
//
//  Created by Felix Fischer on 02/08/2023.
//

import XCTest
@testable import MoveSingleAPISwift



final class ProtobufGeneratorExtrinsicsTests: XCTestCase {

    func testExtrinsics() {
        let extrinsics = ProtobufGenerator.extrinsics(from: .mock)
        XCTAssertEqual(extrinsics.transform.translation.x, 10)
        XCTAssertEqual(extrinsics.transform.translation.y, 11)
        XCTAssertEqual(extrinsics.transform.translation.z, 12)
        XCTAssertEqual(extrinsics.transform.orientation.rotationType, .matrix)
        XCTAssertEqual(extrinsics.transform.orientation.rotationValues, [1, 2, 3, 4, 5, 6, 7, 8, 9])
    }

}
