//
//  CameraPositionData.swift
//  
//
//  Created by Felix Fischer on 28/07/2023.
//

import CoreMotion
import AVFoundation

public struct CameraPositionData {
    let gyroData: CMGyroData?
    let accelerometerData: CMAccelerometerData?
    let magnetometerData: CMMagnetometerData?
    let deviceMotion: CMDeviceMotion?
    let extrinsicMatrix: matrix_float4x3?

    public init(gyroData: CMGyroData?, accelerometerData: CMAccelerometerData?, magnetometerData: CMMagnetometerData?, deviceMotion: CMDeviceMotion?, extrinsicMatrix: matrix_float4x3?) {
        self.gyroData = gyroData
        self.accelerometerData = accelerometerData
        self.magnetometerData = magnetometerData
        self.deviceMotion = deviceMotion
        self.extrinsicMatrix = extrinsicMatrix
    }
}
