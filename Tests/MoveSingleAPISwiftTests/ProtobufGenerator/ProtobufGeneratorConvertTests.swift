//
//  ProtobufGeneratorConvertTests.swift
//  
//
//  Created by Move.ai on 03/08/2023.
//

import XCTest
@testable import MoveSingleAPISwift

final class ProtobufGeneratorConvertTests: XCTestCase {
	
	func testConvert() {
		let pixels = ProtobufGenerator.convert(buffer: .mock)
		XCTAssertEqual(pixels.count, 100*100)
	}
}
