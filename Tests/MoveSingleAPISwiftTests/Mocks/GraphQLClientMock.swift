//
//  File.swift
//  
//
//  Created by Felix Fischer on 27/07/2023.
//

import Foundation
import MoveSingleGraphQLTestMocks
import ApolloTestSupport
import MoveSingleGraphQL
@testable import MoveSingleAPISwift

class GraphQLClientMock: GraphQLClient {
    func createFile(type: String) async throws -> CreateFileMutation.Data.File {
        let mock = Mock<File>()
        let model = CreateFileMutation.Data.from(mock)
        return model.file
    }

    func getFile(id: String) async throws -> FileQuery.Data.File {
        let mock = Mock<File>()
        let model = FileQuery.Data.from(mock)
        return model.file
    }

    func createTake(videoFileId: String, moveFileId: String) async throws -> CreateTakeMutation.Data.Take {
        let mock = Mock<Take>()
        let model = CreateTakeMutation.Data.from(mock)
        return model.take
    }

    func getTake(id: String) async throws -> TakeQuery.Data.Take {
        let mock = Mock<Take>()
        let model = TakeQuery.Data.from(mock)
        return model.take
    }

    func createJob(takeId: String) async throws -> CreateJobMutation.Data.Job {
        let mock = Mock<Job>()
        let model = CreateJobMutation.Data.from(mock)
        return model.job
    }

    func getJob(id: String) async throws -> JobQuery.Data.Job {
        let mock = Mock<Job>()
        let model = JobQuery.Data.from(mock)
        return model.job
    }


}
