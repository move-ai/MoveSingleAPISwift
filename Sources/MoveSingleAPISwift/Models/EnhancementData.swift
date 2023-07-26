//
//  File.swift
//  
//
//  Created by Felix Fischer on 28/07/2023.
//

public struct EnhancementData {
    let cameraDesignData: CameraDesignData?
    let cameraPositionData: CameraPositionData?
    let depthSensorData: DepthSensorData?

    public init(cameraDesignData: CameraDesignData?, cameraPositionData: CameraPositionData?, depthSensorData: DepthSensorData?) {
        self.cameraDesignData = cameraDesignData
        self.cameraPositionData = cameraPositionData
        self.depthSensorData = depthSensorData
    }
}
