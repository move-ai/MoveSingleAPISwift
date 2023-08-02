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

        let col1 = simd_float3(x: 1, y: 2, z: 3)
        let col2 = simd_float3(x: 4, y: 5, z: 6)
        let col3 = simd_float3(x: 7, y: 8, z: 9)
        var intrinsicMatrix = matrix_float3x3(columns: (col1, col2, col3))
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
