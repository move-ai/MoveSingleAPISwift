public struct MoveSingleAPISwift {
    public init(apiKey: String, environment: GraphQLEnvironment = .production) {
        DependencyContainer.register(GraphQLClientImpl(
            apiKey: apiKey,
            environment: environment
        ) as GraphQLClient)
    }
}
