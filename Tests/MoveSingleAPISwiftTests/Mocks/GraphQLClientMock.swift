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

    private let presignedUrl: String
    private let jobState: String

    init(presignedUrl: String = "http:www.move.ai", jobState: String = "NOT STARTED") {
        self.presignedUrl = presignedUrl
        self.jobState = jobState
    }

    func createFile(type: String) async throws -> CreateFileMutation.Data.File {
        let mock = Mock<MoveSingleGraphQLTestMocks.File>()
        mock.id = UUID().uuidString
        mock.presignedUrl = presignedUrl
        let model = CreateFileMutation.Data.File.from(mock)
        return model
    }

    func getFile(id: String) async throws -> FileQuery.Data.File {
        let mock = Mock<MoveSingleGraphQLTestMocks.File>()
        mock.presignedUrl = presignedUrl
        let model = FileQuery.Data.File.from(mock)
        return model
    }

    func createTake(videoFileId: String, moveFileId: String) async throws -> CreateTakeMutation.Data.Take {
        let mock = Mock<MoveSingleGraphQLTestMocks.Take>()
        mock.id = UUID().uuidString
        let model = CreateTakeMutation.Data.Take.from(mock)
        return model
    }

    func getTake(id: String) async throws -> TakeQuery.Data.Take {
        let mock = Mock<MoveSingleGraphQLTestMocks.Take>()
        let model = TakeQuery.Data.Take.from(mock)
        return model
    }

    func createJob(takeId: String) async throws -> CreateJobMutation.Data.Job {
        let mock = Mock<MoveSingleGraphQLTestMocks.Job>()
        mock.id = UUID().uuidString
        mock.state = "NOT STARTED"
        let model = CreateJobMutation.Data.Job.from(mock)
        return model
    }

    func getJob(id: String) async throws -> JobQuery.Data.Job {
        let mock = Mock<MoveSingleGraphQLTestMocks.Job>()
        mock.state = jobState
        if jobState == "FINISHED" {
            mock.outputs = []
            mock.outputs?.append(
                .init(
                    file: .init(
                        id: UUID().uuidString,
                        presignedUrl: "http://www.move.ai"
                    ),
                    key: "move"
                )
            )

        }
        let model = JobQuery.Data.Job.from(mock)
        return model
    }


}
