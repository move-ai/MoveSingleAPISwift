//
//  File.swift
//  
//
//  Created by Felix Fischer on 02/08/2023.
//

import AVFoundation
import CoreFoundation

extension CMSampleBuffer {
    static var mock: CMSampleBuffer = {
        var pixelBuffer: CVPixelBuffer? = nil
        CVPixelBufferCreate(kCFAllocatorDefault, 100, 100, kCVPixelFormatType_32BGRA, nil, &pixelBuffer)

        var info = CMSampleTimingInfo()
        info.presentationTimeStamp = .zero
        info.duration = .invalid
        info.decodeTimeStamp = .invalid

        var formatDesc: CMFormatDescription? = nil
        CMVideoFormatDescriptionCreateForImageBuffer(allocator: kCFAllocatorDefault, imageBuffer: pixelBuffer!, formatDescriptionOut: &formatDesc)

        var sampleBuffer: CMSampleBuffer? = nil
        CMSampleBufferCreateReadyWithImageBuffer(allocator: kCFAllocatorDefault, imageBuffer: pixelBuffer!, formatDescription: formatDesc!, sampleTiming: &info, sampleBufferOut: &sampleBuffer)

        var intrinsicMatrix = simd_float3x3.mock
        var cfData = CFDataCreate(kCFAllocatorDefault, &intrinsicMatrix, MemoryLayout.size(ofValue: intrinsicMatrix))!

        CMSetAttachment(
            sampleBuffer!,
            key: kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix,
            value: cfData,
            attachmentMode: .zero
        )

        return sampleBuffer!
    }()
}
