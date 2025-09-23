import Foundation
import os

public final class Move {

    private var sessionClient: URLSessionClient
    private var fileStorage: FileStorageClient
    private var graphQLClient: GraphQLClient
    private let logger = Logger()

    public init() {
        sessionClient = URLSessionClientImpl()
        fileStorage = FileStorageClientImpl()
        DependencyContainer.register(fileStorage)
        graphQLClient = GraphQLClientImpl()
        DependencyContainer.register(graphQLClient)
        DependencyContainer.register(sessionClient)
    }

    public func configure(
        apiKey: String,
        environment: GraphQLEnvironment = .production,
        outputDirectory: String = "",
        graphQLCertificates: [Data]? = nil,
        fileStorageCertificates: [Data]? = nil
    ) {
        sessionClient.configure(certificates: fileStorageCertificates)
        fileStorage.configure(outputDirectory: outputDirectory)
        graphQLClient.configure(apiKey: apiKey, environment: environment, certificates: graphQLCertificates)
    }

    public func createTake(
        takeID: String,
        videoURL: URL,
        enhancementData: [EnhancementData]? = nil,
        configuration: Configuration = .default,
        metadata: [String: AnyHashable] = [:]
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
        
        var metadata = metadata
        metadata["_move_one_camera"] = configuration.camera.rawValue
        
        let take = Take(takeID: takeID, videoFile: videoFile, moveFile: moveFile, metadata: metadata)
        return take
    }

    public func registerForNotifications(clientID: String, events: [NotificationEvents]) async throws {
        let webhookEndpoint = try await graphQLClient.registerForNotifications(clientID: clientID, events: events)
        print("\(webhookEndpoint.events ?? [])")
    }

    
}
