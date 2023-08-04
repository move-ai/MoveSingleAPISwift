//
//  FrameMock.swift
//  
//
//  Created by Felix Fischer on 04/08/2023.
//

import Foundation
@testable import MoveSingleAPISwift

extension Frame {
    static let mock = Frame(
        sampleBuffer: .mock,
        enhancementData: .mock
    )
}

extension EnhancementData {
    static let mock = EnhancementData(
        cameraPositionData: nil,
        depthSensorData: DepthSensorData(depthData: .mock)
    )
}
