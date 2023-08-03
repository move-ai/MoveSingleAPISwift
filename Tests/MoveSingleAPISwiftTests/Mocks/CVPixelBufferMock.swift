//
//  CVPixelBufferMock.swift
//  
//
//  Created by Move.ai on 03/08/2023.
//

import UIKit
import AVFoundation

extension CVPixelBuffer {
	static var mock: CVPixelBuffer = {
		let attrs = [
			kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
			kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue
		] as CFDictionary
		
		var pixelBuffer: CVPixelBuffer?
		CVPixelBufferCreate(
			kCFAllocatorDefault,
			100,
			100,
			kCVPixelFormatType_32ARGB,
			attrs,
			&pixelBuffer
		)
		
		let image = UIImage.imageWithColor(color: .white)
		
		CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
		let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
		
		if let context = CGContext(
			data: pixelData,
			width: 100,
			height: 100,
			bitsPerComponent: 8,
			bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!),
			space: CGColorSpaceCreateDeviceRGB(),
			bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue
		) {
			context.translateBy(x: 0, y: 100)
			context.scaleBy(x: 1.0, y: -1.0)
			
			UIGraphicsPushContext(context)
			image.draw(in: CGRect(x: 0, y: 0, width: 100, height: 1))
			UIGraphicsPopContext()
		}
		
		CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
		
		return pixelBuffer!
	}()
}
