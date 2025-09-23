// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension MoveSingleGraphQL {
  class JobQuery: GraphQLQuery {
    static let operationName: String = "Job"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query Job($jobId: ID!) { job: getJob(jobId: $jobId) { __typename state outputs { __typename key file { __typename id presignedUrl } } } }"#
      ))

    public var jobId: ID

    public init(jobId: ID) {
      self.jobId = jobId
    }

    public var __variables: Variables? { ["jobId": jobId] }

    struct Data: MoveSingleGraphQL.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("getJob", alias: "job", Job.self, arguments: ["jobId": .variable("jobId")]),
      ] }

      ///   Get job details from given job id.
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
          .field("state", String?.self),
          .field("outputs", [Output?]?.self),
        ] }

        ///   Current status of the job
        var state: String? { __data["state"] }
        ///   Outputs of this job
        var outputs: [Output?]? { __data["outputs"] }

        /// Job.Output
        ///
        /// Parent Type: `AdditionalFile`
        struct Output: MoveSingleGraphQL.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.AdditionalFile }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("key", String.self),
            .field("file", File.self),
          ] }

          ///   Type of additional file
          var key: String { __data["key"] }
          ///   Reference to the additional file object
          var file: File { __data["file"] }

          /// Job.Output.File
          ///
          /// Parent Type: `File`
          struct File: MoveSingleGraphQL.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.File }
            static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("id", MoveSingleGraphQL.ID.self),
              .field("presignedUrl", MoveSingleGraphQL.AWSURL?.self),
            ] }

            ///   Unique identifier for a File.
            var id: MoveSingleGraphQL.ID { __data["id"] }
            ///   Url to upload/download the file. When creating a file, this attribute will return a upload url. Otherwise, this attribute will represent a download url.
            var presignedUrl: MoveSingleGraphQL.AWSURL? { __data["presignedUrl"] }
          }
        }
      }
    }
  }

}