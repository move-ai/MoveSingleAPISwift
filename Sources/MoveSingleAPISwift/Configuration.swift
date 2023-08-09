//
//  File.swift
//  
//
//  Created by Felix Fischer on 08/08/2023.
//

import Foundation

public struct Configuration {
    let camera: Camera
    let includeIMUData: Bool
    let includeLidarData: Bool
    let useDeviceMotionUserAcceleration: Bool
    let useDeviceMotionRotationRate: Bool

    public init(
        camera: Camera,
        includeIMUData: Bool,
        includeLidarData: Bool,
        useDeviceMotionUserAcceleration: Bool,
        useDeviceMotionRotationRate: Bool
    ) {
        self.camera = camera
        self.includeIMUData = includeIMUData
        self.includeLidarData = includeLidarData
        self.useDeviceMotionUserAcceleration = useDeviceMotionUserAcceleration
        self.useDeviceMotionRotationRate = useDeviceMotionRotationRate
    }

    public enum Camera: String, CaseIterable, Identifiable, CustomStringConvertible, Equatable, Codable {
        case front = "Front"
        case back = "Back"
        case backLiDAR = "Back+LiDAR"

        public var id: Self { self }
        public var description: String { self.rawValue }
        public var pbCameraName: String {
            switch self {
            case .front:
                return "iPhoneFrontRGB"
            case .back:
                return "iPhoneBackRGB"
            case .backLiDAR:
                return "iPhoneBackLidar"
            }
        }
    }

    public static let `default` = Configuration(
        camera: .front,
        includeIMUData: true,
        includeLidarData: true,
        useDeviceMotionUserAcceleration: false,
        useDeviceMotionRotationRate: false
    )
}
