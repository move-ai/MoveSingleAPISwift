// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class JobQuery: GraphQLQuery {
  public static let operationName: String = "Job"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Job($jobId: ID!) { job: getJob(jobId: $jobId) { __typename state outputs { __typename key file { __typename id presignedUrl } } } }"#
    ))

  public var jobId: ID

  public init(jobId: ID) {
    self.jobId = jobId
  }

  public var __variables: Variables? { ["jobId": jobId] }

  public struct Data: MoveSingleGraphQL.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getJob", alias: "job", Job.self, arguments: ["jobId": .variable("jobId")]),
    ] }

    ///   Get job details from given job id.
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
        .field("state", String?.self),
        .field("outputs", [Output?]?.self),
      ] }

      ///   Current status of the job
      public var state: String? { __data["state"] }
      ///   Outputs of this job
      public var outputs: [Output?]? { __data["outputs"] }

      /// Job.Output
      ///
      /// Parent Type: `AdditionalFile`
      public struct Output: MoveSingleGraphQL.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.AdditionalFile }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("key", String.self),
          .field("file", File.self),
        ] }

        ///   Type of additional file
        public var key: String { __data["key"] }
        ///   Reference to the additional file object
        public var file: File { __data["file"] }

        /// Job.Output.File
        ///
        /// Parent Type: `File`
        public struct File: MoveSingleGraphQL.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.File }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", MoveSingleGraphQL.ID.self),
            .field("presignedUrl", MoveSingleGraphQL.AWSURL?.self),
          ] }

          ///   Unique identifier for a File.
          public var id: MoveSingleGraphQL.ID { __data["id"] }
          ///   Url to upload/download the file. When creating a file, this attribute will return a upload url. Otherwise, this attribute will represent a download url.
          public var presignedUrl: MoveSingleGraphQL.AWSURL? { __data["presignedUrl"] }
        }
      }
    }
  }
}
