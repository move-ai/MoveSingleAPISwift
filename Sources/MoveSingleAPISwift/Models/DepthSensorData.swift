//
//  File.swift
//  
//
//  Created by Felix Fischer on 28/07/2023.
//

import AVFoundation

public struct DepthSensorData {
    let depthData: AVDepthData

    public init(depthData: AVDepthData) {
        self.depthData = depthData
    }
}
