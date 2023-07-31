//
//  File.swift
//  
//
//  Created by Felix Fischer on 28/07/2023.
//

import CoreMotion

struct CameraPositionData {
    let gyroData: CMGyroData
    let accelerometerData: CMAccelerometerData
    let magnetometerData: CMMagnetometerData
    let deviceMotion: CMDeviceMotion
}
