// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension MoveSingleGraphQL {
  class CreateSingleCamJobMutation: GraphQLMutation {
    static let operationName: String = "CreateSingleCamJob"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation CreateSingleCamJob($takeId: String!, $metadata: AWSJSON!) { job: createSingleCamJob(takeId: $takeId, metadata: $metadata) { __typename id state } }"#
      ))

    public var takeId: String
    public var metadata: AWSJSON

    public init(
      takeId: String,
      metadata: AWSJSON
    ) {
      self.takeId = takeId
      self.metadata = metadata
    }

    public var __variables: Variables? { [
      "takeId": takeId,
      "metadata": metadata
    ] }

    struct Data: MoveSingleGraphQL.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("createSingleCamJob", alias: "job", Job.self, arguments: [
          "takeId": .variable("takeId"),
          "metadata": .variable("metadata")
        ]),
      ] }

      ///   Initialize processing a job to generate animation from a take.
      var job: Job { __data["job"] }

      /// Job
      ///
      /// Parent Type: `Job`
      struct Job: MoveSingleGraphQL.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.Job }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", MoveSingleGraphQL.ID.self),
          .field("state", String?.self),
        ] }

        ///   Unique identifier for the job
        var id: MoveSingleGraphQL.ID { __data["id"] }
        ///   Current status of the job
        var state: String? { __data["state"] }
      }
    }
  }

}