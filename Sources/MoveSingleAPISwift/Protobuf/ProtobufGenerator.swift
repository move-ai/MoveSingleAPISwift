//
//  File.swift
//  
//
//  Created by Felix Fischer on 31/07/2023.
//

import Foundation
import AVFoundation
import CoreMotion

final class ProtobufGenerator {

    static func generate(from enhancementData: [EnhancementData], config: Configuration) async throws -> Data {
        return try await Task {
            var observations = Observations()
            var depthSequence = DepthSequence()

            if let lastEnhancementDataFrame = enhancementData.last {
                depthSequence.camera = camera(from: lastEnhancementDataFrame, config: config)
            }

            enhancementData.forEach { enhancementDataFrame in
                var odometryInstance = OdometryInstance()

                if let extrinsicMatrix = enhancementDataFrame.depthSensorData?.depthData.cameraCalibrationData?.extrinsicMatrix {
                    odometryInstance.coordinateSystem.transform = transform(from: extrinsicMatrix)
                }

                if config.includeIMUData, let cameraPositionData = enhancementDataFrame.cameraPositionData {
                    odometryInstance.imu = imu(from: cameraPositionData, config: config)
                }

                depthSequence.camera.odometry.trajectory.append(odometryInstance)

                if config.includeLidarData, let depthData = enhancementDataFrame.depthSensorData?.depthData {
                    depthSequence.frames.append(depthMap(from: depthData))
                }
            }
            observations.lidars.append(depthSequence)

            let data = try observations.serializedData()
            return data
        }.value
    }

    static func camera(from enhancementData: EnhancementData, config: Configuration) -> Camera {
        var camera = Camera()
        camera.name = config.camera.pbCameraName

        if let cameraDesignData = enhancementData.cameraDesignData {
            camera.intrinsics = intrinsic(from: cameraDesignData)
        }
        if let extrinsicMatrix = enhancementData.depthSensorData?.depthData.cameraCalibrationData?.extrinsicMatrix {
            camera.extrinsics = extrinsics(from: extrinsicMatrix)
        }
        return camera
    }

    static func intrinsic(from cameraDesignData: CameraDesignData) -> Camera.Intrinsics {
        var intrinsics = Camera.Intrinsics()
        intrinsics.centerPointX = cameraDesignData.intrinsicMatrix[2][0]
        intrinsics.centerPointY = cameraDesignData.intrinsicMatrix[2][1]

        intrinsics.focalLengthX = cameraDesignData.intrinsicMatrix[0][0]
        intrinsics.focalLengthY = cameraDesignData.intrinsicMatrix[1][1]

        intrinsics.skew = cameraDesignData.intrinsicMatrix[0][1]
        intrinsics.resolution = Camera.Intrinsics.Resolution()
        intrinsics.resolution.width = Int32(cameraDesignData.width)
        intrinsics.resolution.height = Int32(cameraDesignData.height)

        return intrinsics
    }

    static func extrinsics(from extrinsicMatrix: matrix_float4x3) -> CoordinateSystem {
        var extrinsics = CoordinateSystem()
        // Translation
        extrinsics.transform = Transform()
        extrinsics.transform.translation = Translation()

        extrinsics.transform.translation.x = extrinsicMatrix[3][0]
        extrinsics.transform.translation.y = extrinsicMatrix[3][1]
        extrinsics.transform.translation.z = extrinsicMatrix[3][2]
        // Rotation
        extrinsics.transform.orientation = Orientation()
        extrinsics.transform.orientation.rotationType = .matrix
        extrinsics.transform.orientation.rotationValues = []

        extrinsics.transform.orientation.rotationValues.append(extrinsicMatrix[0][0])
        extrinsics.transform.orientation.rotationValues.append(extrinsicMatrix[0][1])
        extrinsics.transform.orientation.rotationValues.append(extrinsicMatrix[0][2])

        extrinsics.transform.orientation.rotationValues.append(extrinsicMatrix[1][0])
        extrinsics.transform.orientation.rotationValues.append(extrinsicMatrix[1][1])
        extrinsics.transform.orientation.rotationValues.append(extrinsicMatrix[1][2])

        extrinsics.transform.orientation.rotationValues.append(extrinsicMatrix[2][0])
        extrinsics.transform.orientation.rotationValues.append(extrinsicMatrix[2][1])
        extrinsics.transform.orientation.rotationValues.append(extrinsicMatrix[2][2])

        return extrinsics
    }

    static func transform(from extrinsicMatrix: matrix_float4x3) -> Transform {
        var trace: Float = 0.0
        var quat: vector_float4 = vector_float4()

        let mat = extrinsicMatrix

        if mat[2][2] < 0 {
            if mat[0][0] > mat[1][1] {
                trace = 1 + mat[0][0] - mat[1][1] - mat[2][2]
                quat = vector_float4(trace, mat[0][1] + mat[1][0], mat[2][0] + mat[0][2], mat[1][2] - mat[2][1])
            } else {
                trace = 1 - mat[0][0] + mat[1][1] - mat[2][2]
                quat = vector_float4(mat[0][1] + mat[1][0], trace, mat[1][2] + mat[2][1], mat[2][0] - mat[0][2])
            }
        } else {
            if mat[0][0] < -mat[1][1] {
                trace = 1 - mat[0][0] - mat[1][1] + mat[2][2]
                quat = vector_float4(mat[2][0] + mat[0][2], mat[1][2] + mat[2][1], trace, mat[0][1] - mat[1][0])
            } else {
                trace = 1 + mat[0][0] + mat[1][1] + mat[2][2]
                quat = vector_float4(mat[1][2] - mat[2][1], mat[2][0] - mat[0][2], mat[0][1] - mat[1][0], trace)
            }
        }

        let traceInverse = 1.0 / (sqrt(trace))
        quat *= traceInverse

        var transform = Transform()

        transform.translation = Translation()
        transform.translation.x = mat[3][0]
        transform.translation.y = mat[3][1]
        transform.translation.z = mat[3][2]

        transform.orientation = Orientation()
        transform.orientation.rotationValues = [quat.x, quat.y, quat.z, quat.w]

        return transform
    }

    static func imu(from cameraPositionData: CameraPositionData, config: Configuration) -> IMU {

        let accVector = config.useDeviceMotionUserAcceleration ? cameraPositionData.deviceMotion?.userAcceleration ?? .init() : cameraPositionData.accelerometerData?.acceleration ?? .init()
        let gyrVector = config.useDeviceMotionRotationRate ? CMRotationRate(
            x: cameraPositionData.deviceMotion?.attitude.pitch ?? 0,
            y: cameraPositionData.deviceMotion?.attitude.roll ?? 0,
            z: cameraPositionData.deviceMotion?.attitude.yaw ?? 0
        ) : cameraPositionData.gyroData?.rotationRate ?? .init()

        var imu = IMU()
        imu.gyrX = Float(gyrVector.x)
        imu.gyrY = Float(gyrVector.y)
        imu.gyrZ = Float(gyrVector.z)
        imu.accX = Float(accVector.x)
        imu.accY = Float(accVector.y)
        imu.accZ = Float(accVector.z)
        imu.magX = Float(cameraPositionData.magnetometerData?.magneticField.x ?? 0)
        imu.magY = Float(cameraPositionData.magnetometerData?.magneticField.y ?? 0)
        imu.magZ = Float(cameraPositionData.magnetometerData?.magneticField.z ?? 0)
        imu.grvX = Float(cameraPositionData.deviceMotion?.gravity.x ?? 0)
        imu.grvY = Float(cameraPositionData.deviceMotion?.gravity.y ?? 0)
        imu.grvZ = Float(cameraPositionData.deviceMotion?.gravity.z ?? 0)

        return imu

    }

    static func depthMap(from depthData: AVDepthData) -> DepthMap {
        let height = CVPixelBufferGetHeight(depthData.depthDataMap)
        let width = CVPixelBufferGetWidth(depthData.depthDataMap)

        var depthMap = DepthMap()
        depthMap.height = Int32(height)
        depthMap.width = Int32(width)

        let depthFloatArray = convert(buffer: depthData.depthDataMap)
        let accuracy = depthData.depthDataAccuracy
        let quality = Float(depthData.depthDataQuality.rawValue)

        if height >= 1 && width >= 1 {
            for row in 0...height - 1 {
                var pbRow = DepthMap.row()
                var conRow = DepthMap.row()
                for col in 0...width - 1 {
                    let depthRow = depthFloatArray[(row * width) + col]
                    pbRow.row.append(depthRow)
                    if accuracy == .absolute {
                        conRow.row.append(quality)
                    } else {
                        conRow.row.append(0)
                    }
                }
                depthMap.map.append(pbRow)
                depthMap.confidence.append(conRow)
            }
        }

        return depthMap
    }

    static func convert(buffer: CVPixelBuffer) -> [Float32] {
        guard let baseAddress = getBaseAddress(for: buffer) else { return [] }
        let sourceDataSize = CVPixelBufferGetDataSize(buffer)
        let width = CVPixelBufferGetWidth(buffer)
        let height = CVPixelBufferGetHeight(buffer)

        let floatPtr = baseAddress.bindMemory(to: Float32.self, capacity: sourceDataSize / 4 )
        let floatBufferPtr = UnsafeBufferPointer(start: floatPtr, count: width * height )

        let array = Array(floatBufferPtr)

        return array
    }

    static func getBaseAddress(for buffer: CVPixelBuffer) -> UnsafeMutableRawPointer? {
        CVPixelBufferLockBaseAddress(buffer, CVPixelBufferLockFlags(rawValue: 0))
        let baseAddress: UnsafeMutableRawPointer? = CVPixelBufferGetBaseAddress(buffer)
        CVPixelBufferUnlockBaseAddress(buffer, CVPixelBufferLockFlags(rawValue: 0))
        return baseAddress
    }
}
