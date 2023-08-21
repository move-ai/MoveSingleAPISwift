//
//  File.swift
//  
//
//  Created by Felix Fischer on 27/07/2023.
//

import Foundation
import ApolloTestSupport
@testable import MoveSingleAPISwift

class GraphQLClientMock: GraphQLClient {

    private let presignedUrl: String
    private let jobState: String

    init(presignedUrl: String = "http:www.move.ai", jobState: String = "NOT STARTED") {
        self.presignedUrl = presignedUrl
        self.jobState = jobState
    }

    func createFile(type: String) async throws -> MoveSingleGraphQL.CreateFileMutation.Data.File {
        let mock = Mock<File>()
        mock.id = UUID().uuidString
        mock.presignedUrl = presignedUrl
        let model = MoveSingleGraphQL.CreateFileMutation.Data.File.from(mock)
        return model
    }

    func getFile(id: String) async throws -> MoveSingleGraphQL.FileQuery.Data.File {
        let mock = Mock<File>()
        mock.presignedUrl = presignedUrl
        let model = MoveSingleGraphQL.FileQuery.Data.File.from(mock)
        return model
    }

    func createTake(videoFileId: String, moveFileId: String) async throws -> MoveSingleGraphQL.CreateTakeMutation.Data.Take {
        let mock = Mock<Take>()
        mock.id = UUID().uuidString
        let model = MoveSingleGraphQL.CreateTakeMutation.Data.Take.from(mock)
        return model
    }

    func getTake(id: String) async throws -> MoveSingleGraphQL.TakeQuery.Data.Take {
        let mock = Mock<Take>()
        let model = MoveSingleGraphQL.TakeQuery.Data.Take.from(mock)
        return model
    }

    func createJob(takeId: String) async throws -> MoveSingleGraphQL.CreateJobMutation.Data.Job {
        let mock = Mock<Job>()
        mock.id = UUID().uuidString
        mock.state = "NOT STARTED"
        let model = MoveSingleGraphQL.CreateJobMutation.Data.Job.from(mock)
        return model
    }
    
    func generateShareCode(fileId: String) async throws -> MoveSingleGraphQL.GenerateShareCodeMutation.Data.ShareCode {
        let mock = Mock<ShareCode>()
        mock.code = "12345678"
        let model = MoveSingleGraphQL.GenerateShareCodeMutation.Data.ShareCode.from(mock)
        return model
    }

    func getJob(id: String) async throws -> MoveSingleGraphQL.JobQuery.Data.Job {
        
        let mock = Mock<Job>()
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
        let model = MoveSingleGraphQL.JobQuery.Data.Job.from(mock)
        return model
    }


}
