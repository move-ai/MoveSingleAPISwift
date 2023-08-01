//
//  File.swift
//  
//
//  Created by Felix Fischer on 28/07/2023.
//

import AVFoundation

public struct Frame {
    let sampleBuffer: CMSampleBuffer // native iOS SampleBuffer Object
    let enhancementData: EnhancementData
}
