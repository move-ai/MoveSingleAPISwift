//
//  FileStorage.swift
//  
//
//  Created by Move.ai on 04/08/2023.
//

import Foundation
import AVFoundation
import VideoToolbox

enum FileStorageError: Error {
	case imageBufferMalformed
	case assetWritterDidNotStartWriting
}

public class FileStorage {
	private lazy var documentDirectoryURL: URL = URL.documentsDirectory.appending(path: "move-single-api")
	
	func saveMove(_ data: Data, fileName: String? = nil) throws -> URL {
		let fileName = fileName ?? UUID().uuidString
		let toURL = documentDirectoryURL.appending(path: "\(fileName).\(FileType.move.fileExtension)")
		try data.write(to: toURL)
		
		return toURL
	}
	
	func saveVideo(_ frames: [Frame], fileName: String? = nil) async throws -> URL {
		guard let imageBuffer = frames.first?.sampleBuffer.imageBuffer else {
			throw FileStorageError.imageBufferMalformed
		}
		
		let outputWidth = CVPixelBufferGetWidth(imageBuffer)
		let outputHeight = CVPixelBufferGetHeight(imageBuffer)
		
		let bps = outputWidth < 2000 ? (5 * 1024 * 1024) : (15 * 1024 * 1024)
		let codecSettings = [
			AVVideoAverageBitRateKey: bps,
			AVVideoMaxKeyFrameIntervalKey: 60,
			AVVideoProfileLevelKey: kVTProfileLevel_HEVC_Main_AutoLevel
		] as [String: Any]
		
		let videoSettings = [
			AVVideoCompressionPropertiesKey: codecSettings,
			AVVideoWidthKey: Int(outputWidth),
			AVVideoHeightKey: Int(outputHeight),
			AVVideoCodecKey: AVVideoCodecType.hevc
		] as [String: Any]
		
		let assetWriterVideoInput = AVAssetWriterInput(mediaType: AVMediaType.video, outputSettings: videoSettings)
		let pixelBufferAdaptor = AVAssetWriterInputPixelBufferAdaptor(
			assetWriterInput: assetWriterVideoInput,
			sourcePixelBufferAttributes: [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
		)
		
		let fileName = fileName ?? UUID().uuidString
		let videoURL = documentDirectoryURL.appending(path: "\(fileName).\(FileType.video.fileExtension)")
		let assetWriter = try AVAssetWriter(url: videoURL, fileType: AVFileType.mp4)
		assetWriterVideoInput.expectsMediaDataInRealTime = true
		assetWriter.add(assetWriterVideoInput)
		
		guard assetWriter.startWriting() else {
			throw FileStorageError.assetWritterDidNotStartWriting
		}
		
		var cmTime: CMTime?
		frames.forEach { frame in
			if assetWriter.status == .writing && cmTime == nil {
				cmTime = CMSampleBufferGetPresentationTimeStamp(frame.sampleBuffer)
				assetWriter.startSession(atSourceTime: cmTime!)
			}
			
			if assetWriter.status == .writing {
				guard let imgBuffer = frame.sampleBuffer.imageBuffer else { return }
				let time = CMSampleBufferGetPresentationTimeStamp(frame.sampleBuffer)
				if assetWriterVideoInput.isReadyForMoreMediaData {
					pixelBufferAdaptor.append(imgBuffer, withPresentationTime: time)
				}
			}
		}
		
		await assetWriter.finishWriting()
		
		return videoURL
	}
}
