# MoveSingleAPI SDK in Swift

## Installation 💻
You can use Swift Package Manager to integrate the library by adding the following dependency in the `Package.swift` file or by adding it directly within Xcode.

`.package(url: "https://github.com/move-ai/MoveSingleAPISwift", from: "1.0.0")`

## Usage 🤩
Import the framework in your project:
```swift
import MoveSingleAPISwift
```

[Create an MoveSingleAPI key](https://move.ai) and add it to your configuration:
```swift
let move = Move(apiKey: "TOKEN")`
```

### Create simple Take
```swift
let take = try await move.createTake(
    takeID: UUID().uuidString, 
    videoURL: // URL to local video file
)
```

### Upload Take
Uploads the video file and the meta data and creates a new take in the system.
```swift
try await take.upload()
```

### Create Job
Take has to be uploaded. This creates a new job that runs the video through the pipeline to generate the animation.
```swift
try await take.createJob()
```

### Get Results
To check for a result, update the status of the current job of the Take, which is the last one created. As soon as the state of the is `finished` the outputfiles can be downloaded.
```swift
try await take.currentJob?.update()
if take.currentJob?.state == .finished {
    try await take.currentJob?.outputFiles[.preview]?.download()
    let localPreviewURL = await take.currentJob?.outputFiles[.preview]?.localURL
}
```

### Create Take with EnhancementData
Enhancement Data is an optional Array of `EnhancementData` for every frame of the video.

#### CameraDesignData
`CameraDesignData` holds the internal size and position data of the camera. The information is extracted a given `CMSampleBuffer`.

```swift
let cameraDesignData = CameraDesignData(from: CMSampleBuffer)
```

#### CameraPositionData
`CameraPositionData` holds the values of different Sensors of the device.
```swift
let cameraPositionData = CameraPositionData(
    gyroData: CMGyroData?, 
    accelerometerData: CMAccelerometerData?, 
    magnetometerData: CMMagnetometerData?, 
    deviceMotion: CMDeviceMotion?
)
```

#### DepthSensorData
`DepthSensorData` holds the depth data provided by the camera
```swift
let depthSensorData = DepthSensorData(depthData: AVDepthData)
```

With theses three values the `EnhancementData` for one frame can be build. All values are optional, but increase the quality of the output.
```swift
let enhancementData = EnhancementData(
    cameraDesignData: cameraDesignData, 
    cameraPositionData: cameraPositionData, 
    depthSensorData: depthSensorData
)

let take = try await move.createTake(
    takeID: UUID().uuidString, 
    videoURL: // URL to local video file,
    enhancementData: enhancementData
)
```

## Licence 📥

The MIT License (MIT)

Copyright (c) 2023 Move

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
