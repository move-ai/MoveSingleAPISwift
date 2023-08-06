//
//  FileStorageTests.swift
//  
//
//  Created by Move.ai on 04/08/2023.
//

import XCTest
import AVFoundation
@testable import MoveSingleAPISwift

final class FileStorageTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

	func testSaveMoveData() async throws {
		let pixelBuffers: [CVPixelBuffer] = [.mock, .mock, .mock, .mock]
		let sampleBuffers = pixelBuffers.compactMap { $0.createSampleBuffer() }
		XCTAssertEqual(sampleBuffers.count, pixelBuffers.count)
		
		let enhancementData = EnhancementData(cameraPositionData: nil, depthSensorData: nil)
		let frames = sampleBuffers.map {
			Frame(sampleBuffer: $0, enhancementData: enhancementData)
		}
		let config = Configuration(
			camera: .back,
			includeIMUData: false,
			includeLidarData: false,
			useDeviceMotionUserAcceleration: false,
			useDeviceMotionRotationRate: false
		)
		let data = try await ProtobufGenerator.generate(from: frames, config: config)
		
		let fileStorage = FileStorage()
		let moveURL = try fileStorage.saveMove(data)
		XCTAssertTrue(FileManager.default.fileExists(atPath: moveURL.path()))
	}

	func testSaveVideoData() async throws {
		let fps: Double = 30
		let scale = CMTimeScale(NSEC_PER_SEC)
		let pixelBuffers: [CVPixelBuffer] = [.mock, .mock, .mock, .mock]
		
		var index = 0
		let sampleBuffers = pixelBuffers.compactMap { pixelBuffer in
			let pts = CMTime(value: CMTimeValue(Double(index) / fps * Double(scale)),
							 timescale: scale)
			let timingInfo = CMSampleTimingInfo(duration: CMTime.invalid,
												presentationTimeStamp: pts,
												decodeTimeStamp: CMTime.invalid)
			
			index += 1
			return pixelBuffer.createSampleBuffer(timingInfo)
		}
		XCTAssertEqual(sampleBuffers.count, pixelBuffers.count)
		
		let enhancementData = EnhancementData(cameraPositionData: nil, depthSensorData: nil)
		let frames = sampleBuffers.map {
			Frame(sampleBuffer: $0,
				  enhancementData: enhancementData
			)
		}
		let fileStorage = FileStorage()
		let videoURL = try await fileStorage.saveVideo(frames)
		XCTAssertTrue(FileManager.default.fileExists(atPath: videoURL.path()))
	}
}
