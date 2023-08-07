//
//  ProtobufGeneratorImuTests.swift
//  
//
//  Created by Felix Fischer on 02/08/2023.
//

import XCTest
@testable import MoveSingleAPISwift

final class ProtobufGeneratorImuTests: XCTestCase {

    func testImuWithoutDeviceMotion() {
        let config = Configuration(
            camera: .front,
            includeIMUData: true,
            includeLidarData: true,
            useDeviceMotionUserAcceleration: false,
            useDeviceMotionRotationRate: false
        )
        let imu = ProtobufGenerator.imu(from: .mock, config: config)

        XCTAssertEqual(imu.gyrX, 1)
        XCTAssertEqual(imu.gyrY, 2)
        XCTAssertEqual(imu.gyrZ, 3)
        XCTAssertEqual(imu.accX, 4)
        XCTAssertEqual(imu.accY, 5)
        XCTAssertEqual(imu.accZ, 6)
        XCTAssertEqual(imu.magX, 7)
        XCTAssertEqual(imu.magY, 8)
        XCTAssertEqual(imu.magZ, 9)
        XCTAssertEqual(imu.grvX, 16)
        XCTAssertEqual(imu.grvY, 17)
        XCTAssertEqual(imu.grvZ, 18)
    }

    func testImuWithUserAcceleration() {
        let config = Configuration(
            camera: .front,
            includeIMUData: true,
            includeLidarData: true,
            useDeviceMotionUserAcceleration: true,
            useDeviceMotionRotationRate: false
        )
        let imu = ProtobufGenerator.imu(from: .mock, config: config)

        XCTAssertEqual(imu.gyrX, 1)
        XCTAssertEqual(imu.gyrY, 2)
        XCTAssertEqual(imu.gyrZ, 3)
        XCTAssertEqual(imu.accX, 10)
        XCTAssertEqual(imu.accY, 11)
        XCTAssertEqual(imu.accZ, 12)
        XCTAssertEqual(imu.magX, 7)
        XCTAssertEqual(imu.magY, 8)
        XCTAssertEqual(imu.magZ, 9)
        XCTAssertEqual(imu.grvX, 16)
        XCTAssertEqual(imu.grvY, 17)
        XCTAssertEqual(imu.grvZ, 18)
    }

    func testImuWithDeviceMotionRotationRate() {
        let config = Configuration(
            camera: .front,
            includeIMUData: true,
            includeLidarData: true,
            useDeviceMotionUserAcceleration: false,
            useDeviceMotionRotationRate: true
        )
        let imu = ProtobufGenerator.imu(from: .mock, config: config)

        XCTAssertEqual(imu.gyrX, 13)
        XCTAssertEqual(imu.gyrY, 14)
        XCTAssertEqual(imu.gyrZ, 15)
        XCTAssertEqual(imu.accX, 4)
        XCTAssertEqual(imu.accY, 5)
        XCTAssertEqual(imu.accZ, 6)
        XCTAssertEqual(imu.magX, 7)
        XCTAssertEqual(imu.magY, 8)
        XCTAssertEqual(imu.magZ, 9)
        XCTAssertEqual(imu.grvX, 16)
        XCTAssertEqual(imu.grvY, 17)
        XCTAssertEqual(imu.grvZ, 18)
    }

    func testImuWithDeviceMotion() {
        let config = Configuration(
            camera: .front,
            includeIMUData: true,
            includeLidarData: true,
            useDeviceMotionUserAcceleration: true,
            useDeviceMotionRotationRate: true
        )
        let imu = ProtobufGenerator.imu(from: .mock, config: config)

        XCTAssertEqual(imu.gyrX, 13)
        XCTAssertEqual(imu.gyrY, 14)
        XCTAssertEqual(imu.gyrZ, 15)
        XCTAssertEqual(imu.accX, 10)
        XCTAssertEqual(imu.accY, 11)
        XCTAssertEqual(imu.accZ, 12)
        XCTAssertEqual(imu.magX, 7)
        XCTAssertEqual(imu.magY, 8)
        XCTAssertEqual(imu.magZ, 9)
        XCTAssertEqual(imu.grvX, 16)
        XCTAssertEqual(imu.grvY, 17)
        XCTAssertEqual(imu.grvZ, 18)
    }

}
