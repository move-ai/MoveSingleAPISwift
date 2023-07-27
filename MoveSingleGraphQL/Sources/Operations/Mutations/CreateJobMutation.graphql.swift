// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CreateJobMutation: GraphQLMutation {
  public static let operationName: String = "CreateJob"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CreateJob($takeId: String!) { job: createJob(takeId: $takeId) { __typename id state } }"#
    ))

  public var takeId: String

  public init(takeId: String) {
    self.takeId = takeId
  }

  public var __variables: Variables? { ["takeId": takeId] }

  public struct Data: MoveSingleGraphQL.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("createJob", alias: "job", Job.self, arguments: ["takeId": .variable("takeId")]),
    ] }

    ///   Initialize processing a job to generate animation from a take.
    public var job: Job { __data["job"] }

    /// Job
    ///
    /// Parent Type: `Job`
    public struct Job: MoveSingleGraphQL.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.Job }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", MoveSingleGraphQL.ID.self),
        .field("state", String?.self),
      ] }

      ///   Unique identifier for the job
      public var id: MoveSingleGraphQL.ID { __data["id"] }
      ///   Current status of the job
      public var state: String? { __data["state"] }
    }
  }
}
