public struct MoveSingleAPISwift {
    public init(apiKey: String, environment: GraphQLEnvironment = .production) {
        DependencyContainer.register(GraphQLClientImpl(
            apiKey: apiKey,
            environment: environment
        ) as GraphQLClient)
        DependencyContainer.register(URLSessionClientImpl() as URLSessionClient)
    }

    public func createTake() {

        let videoFile = File(type: .video)
        let moveFile = File(type: .move)
        let take = Take(videoFile: videoFile, moveFile: moveFile)

    }
}
