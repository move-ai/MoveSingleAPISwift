//
//  File.swift
//  
//
//  Created by Felix Fischer on 26/07/2023.
//

import Foundation
import Apollo
import MoveSingleGraphQL

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
    func createFile(type: String) async throws -> CreateFileMutation.Data.File
    func getFile(id: String) async throws -> FileQuery.Data.File
    func createTake(videoFileId: String, moveFileId: String) async throws -> CreateTakeMutation.Data.Take
    func getTake(id: String) async throws -> TakeQuery.Data.Take
    func createJob(takeId: String) async throws -> CreateJobMutation.Data.Job
    func getJob(id: String) async throws -> JobQuery.Data.Job
}

final class GraphQLClientImpl: GraphQLClient {

    private let apiKey: String
    private let environment: GraphQLEnvironment

    private lazy var apollo: ApolloClient = {
        let client = Apollo.URLSessionClient()
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let provider = NetworkInterceptorProvider(apiKey: apiKey, client: client, store: store)
        let transport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: environment.url)
        return ApolloClient(networkTransport: transport, store: store)
    }()

    init(apiKey: String, environment: GraphQLEnvironment = .production) {
        self.apiKey = apiKey
        self.environment = environment
    }

    func createFile(type: String) async throws -> CreateFileMutation.Data.File {
        return try await withCheckedThrowingContinuation { continuation in
            apollo.perform(mutation: CreateFileMutation(type: type)) { result in
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

    func getFile(id: String) async throws -> FileQuery.Data.File {
        return try await withCheckedThrowingContinuation { continuation in
            apollo.fetch(query: FileQuery(fileId: id)) { result in
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

    func createTake(videoFileId: String, moveFileId: String) async throws -> CreateTakeMutation.Data.Take {
        return try await withCheckedThrowingContinuation { continuation in
            apollo.perform(mutation: CreateTakeMutation(videoFileId: videoFileId, moveFileId: moveFileId)) { result in
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

    func getTake(id: String) async throws -> TakeQuery.Data.Take {
        return try await withCheckedThrowingContinuation { continuation in
            apollo.fetch(query: TakeQuery(takeId: id)) { result in
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

    func createJob(takeId: String) async throws -> CreateJobMutation.Data.Job {
        return try await withCheckedThrowingContinuation { continuation in
            apollo.perform(mutation: CreateJobMutation(takeId: takeId)) { result in
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

    func getJob(id: String) async throws -> JobQuery.Data.Job {
        return try await withCheckedThrowingContinuation { continuation in
            apollo.fetch(query: JobQuery(jobId: id)) { result in
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
}
