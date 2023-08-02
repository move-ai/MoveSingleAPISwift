//
//  ProtobufGeneratorExtrinsicsTests.swift
//  
//
//  Created by Felix Fischer on 02/08/2023.
//

import XCTest
import AVFoundation
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

extension simd_float4x3 {
    static let mock: simd_float4x3 = {
        let col1 = simd_float3(x: 1, y: 2, z: 3)
        let col2 = simd_float3(x: 4, y: 5, z: 6)
        let col3 = simd_float3(x: 7, y: 8, z: 9)
        let col4 = simd_float3(x: 10, y: 11, z: 12)
        let matrix = matrix_float4x3(col1, col2, col3, col4)
        return matrix
    }()
}
