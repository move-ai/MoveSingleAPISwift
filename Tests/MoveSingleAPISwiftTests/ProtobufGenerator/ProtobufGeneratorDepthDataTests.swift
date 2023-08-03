//
//  ProtobufGeneratorDepthDataTests.swift
//  
//
//  Created by Move.ai on 03/08/2023.
//

import XCTest
@testable import MoveSingleAPISwift

final class ProtobufGeneratorDepthDataTests: XCTestCase {
	func testDepthData() {
		let depthMap = ProtobufGenerator.depthMap(from: .mock)
		XCTAssertEqual(depthMap.width, 100)
		XCTAssertEqual(depthMap.height, 100)
	}
}
