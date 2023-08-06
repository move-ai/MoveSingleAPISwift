//
//  CVPixelBuffer.swift
//  
//
//  Created by Move.ai on 04/08/2023.
//

import AVFoundation

extension CVPixelBuffer {
	func createSampleBuffer(_ timingInfo: CMSampleTimingInfo? = nil) -> CMSampleBuffer? {
		var sampleBuffer: CMSampleBuffer?
		
		var timimgInfo = timingInfo ?? CMSampleTimingInfo()
		var formatDescription: CMFormatDescription? = nil
		CMVideoFormatDescriptionCreateForImageBuffer(
			allocator: kCFAllocatorDefault,
			imageBuffer: self,
			formatDescriptionOut: &formatDescription
		)
		
		CMSampleBufferCreateReadyWithImageBuffer(
			allocator: kCFAllocatorDefault,
			imageBuffer: self,
			formatDescription: formatDescription!,
			sampleTiming: &timimgInfo,
			sampleBufferOut: &sampleBuffer
		)
		
		return sampleBuffer
	}
}
