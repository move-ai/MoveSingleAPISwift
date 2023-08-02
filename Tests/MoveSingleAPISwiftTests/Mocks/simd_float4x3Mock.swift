//
//  simd_float4x3Mock.swift
//  
//
//  Created by Felix Fischer on 02/08/2023.
//

import AVFoundation

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
