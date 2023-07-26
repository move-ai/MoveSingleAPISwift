//
//  File.swift
//  
//
//  Created by Felix Fischer on 28/07/2023.
//

import CoreMotion

public struct CameraPositionData {
    let gyroData: CMGyroData?
    let accelerometerData: CMAccelerometerData?
    let magnetometerData: CMMagnetometerData?
    let deviceMotion: CMDeviceMotion?

    public init(gyroData: CMGyroData?, accelerometerData: CMAccelerometerData?, magnetometerData: CMMagnetometerData?, deviceMotion: CMDeviceMotion?) {
        self.gyroData = gyroData
        self.accelerometerData = accelerometerData
        self.magnetometerData = magnetometerData
        self.deviceMotion = deviceMotion
    }
}
