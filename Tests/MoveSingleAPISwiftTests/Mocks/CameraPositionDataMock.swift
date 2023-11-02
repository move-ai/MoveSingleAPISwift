//
//  File.swift
//  
//
//  Created by Felix Fischer on 02/08/2023.
//

import Foundation
import CoreMotion
@testable import MoveSingleAPISwift

extension CameraPositionData {
    static var mock: CameraPositionData = {
        CameraPositionData(
            gyroData: CMGyroDataMock(),
            accelerometerData: CMAccelerometerDataMock(),
            magnetometerData: CMMagnetometerDataMock(),
            deviceMotion: CMDeviceMotionMock(),
            extrinsicMatrix: nil,
            viewMatrix: nil,
            arCameraStatus: 0
        )
    }()
}

final class CMGyroDataMock: CMGyroData {
    override var rotationRate: CMRotationRate {
        return CMRotationRate(x: 1, y: 2, z: 3)
    }
}

final class CMAccelerometerDataMock: CMAccelerometerData {
    override var acceleration: CMAcceleration {
        CMAcceleration(x: 4, y: 5, z: 6)
    }
}

final class CMMagnetometerDataMock: CMMagnetometerData {
    override var magneticField: CMMagneticField {
        CMMagneticField(x: 7, y: 8, z: 9)
    }
}

final class CMDeviceMotionMock: CMDeviceMotion {
    override var userAcceleration: CMAcceleration {
        CMAcceleration(x: 10, y: 11, z: 12)
    }

    override var attitude: CMAttitude {
        CMAttitudeMock()
    }

    override var gravity: CMAcceleration {
        CMAcceleration(x: 16, y: 17, z: 18)
    }
}

final class CMAttitudeMock: CMAttitude {
    override var pitch: Double {
        13
    }

    override var roll: Double {
        14
    }

    override var yaw: Double {
        15
    }
}
