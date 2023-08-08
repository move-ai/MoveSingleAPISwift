//
//  File.swift
//  
//
//  Created by Felix Fischer on 08/08/2023.
//

import AVFoundation

public struct CameraDesignData {
    let height: Int
    let width: Int
    let intrinsicMatrix: matrix_float3x3

    public init(from sampleBuffer: CMSampleBuffer) {
        if let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) {
            height = CVPixelBufferGetHeight(imageBuffer)
            width = CVPixelBufferGetWidth(imageBuffer)
        } else {
            height = 0
            width = 0
        }

        var intrinsicMatrix = matrix_float3x3()
        if let camData = CMGetAttachment(sampleBuffer,
                                         key: kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix,
                                         attachmentModeOut: nil) as? Data {
            intrinsicMatrix = camData.withUnsafeBytes { $0.pointee }
        }

        self.intrinsicMatrix = intrinsicMatrix
    }
}
