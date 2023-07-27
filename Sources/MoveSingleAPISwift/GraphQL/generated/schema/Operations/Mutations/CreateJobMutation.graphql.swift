// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GraphQL {
  class CreateJobMutation: GraphQLMutation {
    static let operationName: String = "CreateJob"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation CreateJob($takeId: String!) { job: createJob(takeId: $takeId) { __typename id state } }"#
      ))

    public var takeId: String

    public init(takeId: String) {
      self.takeId = takeId
    }

    public var __variables: Variables? { ["takeId": takeId] }

    struct Data: GraphQL.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { GraphQL.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("createJob", alias: "job", Job.self, arguments: ["takeId": .variable("takeId")]),
      ] }

      ///   Initialize processing a job to generate animation from a take.
      var job: Job { __data["job"] }

      /// Job
      ///
      /// Parent Type: `Job`
      struct Job: GraphQL.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { GraphQL.Objects.Job }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", GraphQL.ID.self),
          .field("state", String?.self),
        ] }

        ///   Unique identifier for the job
        var id: GraphQL.ID { __data["id"] }
        ///   Current status of the job
        var state: String? { __data["state"] }
      }
    }
  }

}