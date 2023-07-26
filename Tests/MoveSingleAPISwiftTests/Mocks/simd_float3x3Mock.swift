//
//  File.swift
//  
//
//  Created by Felix Fischer on 08/08/2023.
//

import simd

extension simd_float3x3 {
    static let mock: simd_float3x3 = {
        let col1 = simd_float3(x: 1, y: 2, z: 3)
        let col2 = simd_float3(x: 4, y: 5, z: 6)
        let col3 = simd_float3(x: 7, y: 8, z: 9)
        return matrix_float3x3(columns: (col1, col2, col3))
    }()
}
