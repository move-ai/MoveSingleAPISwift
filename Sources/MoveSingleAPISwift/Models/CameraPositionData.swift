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
    let viewMatrix: matrix_float4x3?
    let intrinsicMatrix: matrix_float3x3?
    let arCameraStatus: Int

    public init(gyroData: CMGyroData?, accelerometerData: CMAccelerometerData?, magnetometerData: CMMagnetometerData?, deviceMotion: CMDeviceMotion?, intrinsicMatrix: matrix_float3x3?, extrinsicMatrix: matrix_float4x3?, viewMatrix: matrix_float4x3?, arCameraStatus: Int) {
        self.gyroData = gyroData
        self.accelerometerData = accelerometerData
        self.magnetometerData = magnetometerData
        self.deviceMotion = deviceMotion
        self.intrinsicMatrix = intrinsicMatrix
        self.extrinsicMatrix = extrinsicMatrix
        self.viewMatrix = viewMatrix
        self.arCameraStatus = arCameraStatus
    }
}
