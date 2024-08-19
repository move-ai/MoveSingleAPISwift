//
//  File.swift
//  
//
//  Created by Felix Fischer on 26/07/2023.
//

import Foundation
import Apollo

enum GraphQLClientError: Error {
    case noDataFound
    case notConfigured
}

public enum GraphQLEnvironment {
    case green
    case production

    var url: URL {
        switch self {
        case .green:
            return URL(string: "https://api-test.move.ai/ugc/graphql")!
        case .production:
            return URL(string: "https://api.move.ai/ugc/graphql")!
        }
    }

    var webhookEndpointURLString: String {
        switch self {
        case .green: return "https://notifications-test.move.ai/moveone/webhook"
        case .production: return "https://notifications.move.ai/moveone/webhook"
        }
    }
}

protocol GraphQLClient {
    func configure(apiKey: String, environment: GraphQLEnvironment, certificates: [Data]?, deviceLabel: String)
    func registerForNotifications(clientID: String, events: [NotificationEvents]) async throws -> MoveSingleGraphQL.WebhookEndpointMutation.Data.UpsertWebhookEndpoint
    func createFile(type: String, metadata: String) async throws -> MoveSingleGraphQL.CreateFileMutation.Data.File
    func getFile(id: String) async throws -> MoveSingleGraphQL.FileQuery.Data.File
    func createTake(videoFileId: String, moveFileId: String, metadata: String) async throws -> MoveSingleGraphQL.CreateSingleCamTakeMutation.Data.Take
    func getTake(id: String) async throws -> MoveSingleGraphQL.TakeQuery.Data.Take
    func createJob(takeId: String, metadata: String) async throws -> MoveSingleGraphQL.CreateSingleCamJobMutation.Data.Job
    func getJob(id: String) async throws -> MoveSingleGraphQL.JobQuery.Data.Job
    func generateShareCode(fileId: String) async throws -> MoveSingleGraphQL.GenerateShareCodeMutation.Data.ShareCode
}

extension GraphQLClient {
    func configure(apiKey: String, environment: GraphQLEnvironment = .production, certificates: [Data]?, deviceLabel: String) {
        configure(apiKey: apiKey, environment: environment, certificates: certificates, deviceLabel: deviceLabel)
    }
}

final class GraphQLClientImpl: GraphQLClient {

    private var apollo: ApolloClient?
    private var apikey: String?
    private var environment: GraphQLEnvironment?
    private var deviceLabel: String?

    func configure(apiKey: String, environment: GraphQLEnvironment, certificates: [Data]?, deviceLabel: String) {
        self.apikey = apiKey
        self.environment = environment
        self.deviceLabel = deviceLabel
        let client = SessionClient(certificates: certificates)
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let provider = NetworkInterceptorProvider(apiKey: apiKey, client: client, store: store)
        let transport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: environment.url)
        apollo = ApolloClient(networkTransport: transport, store: store)
    }

    func registerForNotifications(clientID: String, events: [NotificationEvents]) async throws -> MoveSingleGraphQL.WebhookEndpointMutation.Data.UpsertWebhookEndpoint {
        return try await withCheckedThrowingContinuation { continuation in
            guard let apollo = apollo,
                  let endpoint = self.environment
            else { continuation.resume(throwing: GraphQLClientError.notConfigured); return }

            apollo.perform(mutation: MoveSingleGraphQL.WebhookEndpointMutation(
                events: .some(events.map { $0.rawValue }),
                uid: clientID,
                url: endpoint.webhookEndpointURLString
            )) { result in
                switch result {
                case .success(let result):
                    if let webhookEndpoint = result.data?.upsertWebhookEndpoint {
                        continuation.resume(returning: webhookEndpoint)
                    } else if let error = result.errors?.first {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(throwing: GraphQLClientError.noDataFound)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func createFile(type: String, metadata: String) async throws -> MoveSingleGraphQL.CreateFileMutation.Data.File {
        return try await withCheckedThrowingContinuation { continuation in
            guard let apollo = apollo else { continuation.resume(throwing: GraphQLClientError.notConfigured); return }
            apollo.perform(mutation: MoveSingleGraphQL.CreateFileMutation(type: type, metadata: metadata)) { result in
                switch result {
                case .success(let result):
                    if let file = result.data?.file {
                        continuation.resume(returning: file)
                    } else if let error = result.errors?.first {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(throwing: GraphQLClientError.noDataFound)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func getFile(id: String) async throws -> MoveSingleGraphQL.FileQuery.Data.File {
        return try await withCheckedThrowingContinuation { continuation in
            guard let apollo = apollo else { continuation.resume(throwing: GraphQLClientError.notConfigured); return }
            apollo.fetch(query: MoveSingleGraphQL.FileQuery(fileId: id), cachePolicy: .fetchIgnoringCacheCompletely) { result in
                switch result {
                case .success(let result):
                    if let file = result.data?.file {
                        continuation.resume(returning: file)
                    } else if let error = result.errors?.first {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(throwing: GraphQLClientError.noDataFound)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func createTake(videoFileId: String, moveFileId: String, metadata: String) async throws -> MoveSingleGraphQL.CreateSingleCamTakeMutation.Data.Take {
        return try await withCheckedThrowingContinuation { continuation in
            guard let apollo = apollo else { continuation.resume(throwing: GraphQLClientError.notConfigured); return }
            
            let sources: [MoveSingleGraphQL.SourceInput]? = [
                MoveSingleGraphQL.SourceInput(deviceLabel: deviceLabel ?? "", fileId: videoFileId, format: .case(.mp4)),
                MoveSingleGraphQL.SourceInput(deviceLabel: deviceLabel ?? "", fileId: moveFileId, format: .case(.move))
            ]

            apollo.perform(mutation: MoveSingleGraphQL.CreateSingleCamTakeMutation(sources: sources.gqlWrapped, metadata: metadata)) { result in
                switch result {
                case .success(let result):
                    if let take = result.data?.take {
                        continuation.resume(returning: take)
                    } else if let error = result.errors?.first {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(throwing: GraphQLClientError.noDataFound)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func getTake(id: String) async throws -> MoveSingleGraphQL.TakeQuery.Data.Take {
        return try await withCheckedThrowingContinuation { continuation in
            guard let apollo = apollo else { continuation.resume(throwing: GraphQLClientError.notConfigured); return }
            apollo.fetch(query: MoveSingleGraphQL.TakeQuery(takeId: id), cachePolicy: .fetchIgnoringCacheCompletely) { result in
                switch result {
                case .success(let result):
                    if let take = result.data?.take {
                        continuation.resume(returning: take)
                    } else if let error = result.errors?.first {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(throwing: GraphQLClientError.noDataFound)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func createJob(takeId: String, metadata: String = "") async throws -> MoveSingleGraphQL.CreateSingleCamJobMutation.Data.Job {
        return try await withCheckedThrowingContinuation { continuation in
            guard let apollo = apollo else { continuation.resume(throwing: GraphQLClientError.notConfigured); return }
            apollo.perform(mutation: MoveSingleGraphQL.CreateSingleCamJobMutation(takeId: takeId, metadata: metadata)) { result in
                switch result {
                case .success(let result):
                    if let job = result.data?.job {
                        continuation.resume(returning: job)
                    } else if let error = result.errors?.first {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(throwing: GraphQLClientError.noDataFound)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func getJob(id: String) async throws -> MoveSingleGraphQL.JobQuery.Data.Job {
        return try await withCheckedThrowingContinuation { continuation in
            guard let apollo = apollo else { continuation.resume(throwing: GraphQLClientError.notConfigured); return }
            apollo.fetch(query: MoveSingleGraphQL.JobQuery(jobId: id), cachePolicy: .fetchIgnoringCacheCompletely) { result in
                switch result {
                case .success(let result):
                    print(result.source)
                    if let job = result.data?.job {
                        continuation.resume(returning: job)
                    } else if let error = result.errors?.first {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(throwing: GraphQLClientError.noDataFound)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
	
    func generateShareCode(fileId: String) async throws -> MoveSingleGraphQL.GenerateShareCodeMutation.Data.ShareCode {
        return try await withCheckedThrowingContinuation { continuation in
            guard let apollo = apollo else { continuation.resume(throwing: GraphQLClientError.notConfigured); return }
            apollo.perform(mutation: MoveSingleGraphQL.GenerateShareCodeMutation(fileId: fileId)) { result in
                switch result {
                case .success(let result):
                    if let job = result.data?.shareCode {
                        continuation.resume(returning: job)
                    } else if let error = result.errors?.first {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(throwing: GraphQLClientError.noDataFound)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
