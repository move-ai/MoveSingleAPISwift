import Foundation
import os

public struct Move {

    private let fileStorage: FileStorageClient
    private let logger = Logger()

    public init(
        apiKey: String,
        environment: GraphQLEnvironment = .production,
        outputDirectory: String = ""
    ) {
        self.fileStorage = FileStorageClientImpl(outputDirectory: outputDirectory)
        DependencyContainer.register(GraphQLClientImpl(
            apiKey: apiKey,
            environment: environment
        ) as GraphQLClient)
        DependencyContainer.register(URLSessionClientImpl() as URLSessionClient)
        DependencyContainer.register(fileStorage)
    }

    public func createTake(
        takeID: String,
        videoURL: URL,
        enhancementData: [EnhancementData]? = nil,
        numberOfRetakes: Int = 0,
        configuration: Configuration = .default,
        rotated: Bool
    ) async throws -> Take {

        var enhancementDataUnwrapped: [EnhancementData] = []
        if let enhancementData = enhancementData {
            enhancementDataUnwrapped = enhancementData
        } else {
            logger.warning("No Enhancement Data was added. Motion results will be impacted.")
        }

        let protobufData = try await ProtobufGenerator.generate(from: enhancementDataUnwrapped, config: configuration)
        let moveFileName = try await fileStorage.saveMove(protobufData)
        let moveFile = File(type: .move, localFileName: moveFileName)
        let videoFile = File(type: .video, localFileName: videoURL.deletingPathExtension().lastPathComponent)

        let takeMetadata = TakeMetadata(camera: configuration.camera, rotated: rotated)
        let take = Take(takeID: takeID, videoFile: videoFile, moveFile: moveFile, metadata: takeMetadata, numberOfRetakes: numberOfRetakes)
        return take
    }
}
