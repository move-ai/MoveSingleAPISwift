// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GraphQL {
  class CreateFileMutation: GraphQLMutation {
    static let operationName: String = "CreateFile"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation CreateFile($type: String!) { file: createFile(type: $type) { __typename id presignedUrl } }"#
      ))

    public var type: String

    public init(type: String) {
      self.type = type
    }

    public var __variables: Variables? { ["type": type] }

    struct Data: GraphQL.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { GraphQL.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("createFile", alias: "file", File.self, arguments: ["type": .variable("type")]),
      ] }

      ///   Create a file with given type (extension) of the file. For example: to create an mp4 file in the system, use `createFile(type: 'mp4')` mutation.
      var file: File { __data["file"] }

      /// File
      ///
      /// Parent Type: `File`
      struct File: GraphQL.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { GraphQL.Objects.File }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", GraphQL.ID.self),
          .field("presignedUrl", GraphQL.AWSURL?.self),
        ] }

        ///   Unique identifier for a File.
        var id: GraphQL.ID { __data["id"] }
        ///   Url to upload/download the file. When creating a file, this attribute will return a upload url. Otherwise, this attribute will represent a download url.
        var presignedUrl: GraphQL.AWSURL? { __data["presignedUrl"] }
      }
    }
  }

}