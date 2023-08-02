//
//  ProtobufGeneratorTransforTests.swift
//  
//
//  Created by Felix Fischer on 02/08/2023.
//

import XCTest
@testable import MoveSingleAPISwift

final class ProtobufGeneratorTransforTests: XCTestCase {

    func testTransform() {
        let transform = ProtobufGenerator.transform(from: .mock)
        XCTAssertEqual(transform.translation.x, 10)
        XCTAssertEqual(transform.translation.y, 11)
        XCTAssertEqual(transform.translation.z, 12)
        XCTAssertEqual(transform.orientation.rotationValues, [-0.5, 1.0, -0.5, 4.0])
    }

}
