// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CreateFileMutation: GraphQLMutation {
  public static let operationName: String = "CreateFile"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CreateFile($type: String!) { file: createFile(type: $type) { __typename id presignedUrl } }"#
    ))

  public var type: String

  public init(type: String) {
    self.type = type
  }

  public var __variables: Variables? { ["type": type] }

  public struct Data: MoveSingleGraphQL.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("createFile", alias: "file", File.self, arguments: ["type": .variable("type")]),
    ] }

    ///   Create a file with given type (extension) of the file. For example: to create an mp4 file in the system, use `createFile(type: 'mp4')` mutation.
    public var file: File { __data["file"] }

    /// File
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
