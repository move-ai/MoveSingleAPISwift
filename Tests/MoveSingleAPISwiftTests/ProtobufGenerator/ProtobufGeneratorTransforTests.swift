//
//  ProtobufGeneratorTransforTests.swift
//  
//
//  Created by Felix Fischer on 02/08/2023.
//

import XCTest
@testable import MoveSingleAPISwift

final class ProtobufGeneratorTransforTests: XCTestCase {

    func testTransformPositive() {
        let transform = ProtobufGenerator.transform(from: .mock)
        XCTAssertEqual(transform.translation.x, 10)
        XCTAssertEqual(transform.translation.y, 11)
        XCTAssertEqual(transform.translation.z, 12)
        XCTAssertEqual(transform.orientation.rotationValues, [-0.5, 1.0, -0.5, 4.0])
    }

    func testTransformNegative() {
        let transform = ProtobufGenerator.transform(from: .mockNegativ)
        XCTAssertEqual(transform.translation.x, -10)
        XCTAssertEqual(transform.translation.y, -11)
        XCTAssertEqual(transform.translation.z, -12)
        XCTAssertEqual(transform.orientation.rotationValues, [3.7416573, -1.6035674, -2.6726124, 0.5345225])
    }

    func testTransform2() {
        let transform = ProtobufGenerator.transform(from: .mock2)
        XCTAssertEqual(transform.translation.x, 10)
        XCTAssertEqual(transform.translation.y, 11)
        XCTAssertEqual(transform.translation.z, 12)
        XCTAssertEqual(transform.orientation.rotationValues, [1.6035674, 3.7416573, 3.7416573, 1.069045])
    }

    func testTransform3() {
        let transform = ProtobufGenerator.transform(from: .mock3)
        XCTAssertEqual(transform.translation.x, 10)
        XCTAssertEqual(transform.translation.y, 11)
        XCTAssertEqual(transform.translation.z, 12)
        XCTAssertEqual(transform.orientation.rotationValues, [2.5819888, 3.6147845, 3.8729832, -0.5163978])
    }

}
