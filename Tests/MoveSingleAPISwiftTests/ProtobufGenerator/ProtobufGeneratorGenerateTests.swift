//
//  ProtobufGeneratorGenerateTests.swift
//  
//
//  Created by Felix Fischer on 04/08/2023.
//

import XCTest
@testable import MoveSingleAPISwift

final class ProtobufGeneratorGenerateTests: XCTestCase {

    func testGenerate() async throws {
        let data = try await ProtobufGenerator.generate(from: [.mock], config: .default)
        XCTAssertEqual(data.count, 81267)
    }

}
