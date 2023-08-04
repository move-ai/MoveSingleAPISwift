public struct MoveSingleAPISwift {
    public init(apiKey: String, environment: GraphQLEnvironment = .production) {
        DependencyContainer.register(GraphQLClientImpl(
            apiKey: apiKey,
            environment: environment
        ) as GraphQLClient)
        DependencyContainer.register(URLSessionClientImpl() as URLSessionClient)
    }

	public func createTake(frames: [Frame], camera: Configuration.Camera) async throws -> Take {
		return try await Task {
			let fileStorage = FileStorage()
			
			let moveFileData = try await ProtobufGenerator.generate(from: frames, config: .init(camera: camera, includeIMUData: false, includeLidarData: false, useDeviceMotionUserAcceleration: false, useDeviceMotionRotationRate: false))
			let moveFileURL = try fileStorage.saveMove(moveFileData)
			let moveFile = File(type: .move, localUrl: moveFileURL)
			
			let videFileURL = try await fileStorage.saveVideo(frames)
			let videoFile = File(type: .video, localUrl: videFileURL)
			
			let take = Take(videoFile: videoFile, moveFile: moveFile)
			return take
		}.value
    }
}
