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
}

protocol GraphQLClient {
    func createFile(type: String) async throws -> MoveSingleGraphQL.CreateFileMutation.Data.File
    func getFile(id: String) async throws -> MoveSingleGraphQL.FileQuery.Data.File
    func createTake(videoFileId: String, moveFileId: String) async throws -> MoveSingleGraphQL.CreateTakeMutation.Data.Take
    func getTake(id: String) async throws -> MoveSingleGraphQL.TakeQuery.Data.Take
    func createJob(takeId: String) async throws -> MoveSingleGraphQL.CreateJobMutation.Data.Job
    func getJob(id: String) async throws -> MoveSingleGraphQL.JobQuery.Data.Job
    func generateShareCode(fileId: String) async throws -> MoveSingleGraphQL.GenerateShareCodeMutation.Data.ShareCode
}

final class GraphQLClientImpl: GraphQLClient {

    private let apollo: ApolloClient

    init(apiKey: String, environment: GraphQLEnvironment = .production) {
        let client = Apollo.URLSessionClient()
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let provider = NetworkInterceptorProvider(apiKey: apiKey, client: client, store: store)
        let transport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: environment.url)
        apollo = ApolloClient(networkTransport: transport, store: store)
    }

    func createFile(type: String) async throws -> MoveSingleGraphQL.CreateFileMutation.Data.File {
        return try await withCheckedThrowingContinuation { continuation in
            apollo.perform(mutation: MoveSingleGraphQL.CreateFileMutation(type: type)) { result in
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

    func createTake(videoFileId: String, moveFileId: String) async throws -> MoveSingleGraphQL.CreateTakeMutation.Data.Take {
        return try await withCheckedThrowingContinuation { continuation in
            apollo.perform(mutation: MoveSingleGraphQL.CreateTakeMutation(videoFileId: videoFileId, moveFileId: moveFileId)) { result in
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

    func createJob(takeId: String) async throws -> MoveSingleGraphQL.CreateJobMutation.Data.Job {
        return try await withCheckedThrowingContinuation { continuation in
            apollo.perform(mutation: MoveSingleGraphQL.CreateJobMutation(takeId: takeId)) { result in
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
