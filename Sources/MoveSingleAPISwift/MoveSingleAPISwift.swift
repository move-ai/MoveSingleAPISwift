import Foundation
import os

public struct MoveSingleAPISwift {

    private let logger = Logger()

    public init(apiKey: String, environment: GraphQLEnvironment = .production) {
        DependencyContainer.register(GraphQLClientImpl(
            apiKey: apiKey,
            environment: environment
        ) as GraphQLClient)
        DependencyContainer.register(URLSessionClientImpl() as URLSessionClient)
    }

    public func createTake(
        takeID: String,
        videoURL: URL,
        enhancementData: [EnhancementData]? = nil,
        configuration: Configuration = .default
    ) async throws -> Take {

        var enhancementDataUnwrapped: [EnhancementData] = []
        if let enhancementData = enhancementData {
            enhancementDataUnwrapped = enhancementData
        } else {
            logger.warning("No Enhancement Data was added. Motion results will be impacted.")
        }

        let protobufData = try await ProtobufGenerator.generate(from: enhancementDataUnwrapped, config: configuration)
        let moveFileURL = try await FileStorage.saveMove(protobufData)
        let moveFile = File(type: .move, localUrl: moveFileURL)
        let videoFile = File(type: .video, localUrl: videoURL)

        let take = Take(takeID: takeID, videoFile: videoFile, moveFile: moveFile)
        return take
    }
}
