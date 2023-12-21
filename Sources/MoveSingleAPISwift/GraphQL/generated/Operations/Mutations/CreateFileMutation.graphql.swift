// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension MoveSingleGraphQL {
  class CreateFileMutation: GraphQLMutation {
    static let operationName: String = "CreateFile"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation CreateFile($type: String!, $metadata: AWSJSON!) { file: createFile(type: $type, metadata: $metadata) { __typename id presignedUrl } }"#
      ))

    public var type: String
    public var metadata: AWSJSON

    public init(
      type: String,
      metadata: AWSJSON
    ) {
      self.type = type
      self.metadata = metadata
    }

    public var __variables: Variables? { [
      "type": type,
      "metadata": metadata
    ] }

    struct Data: MoveSingleGraphQL.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("createFile", alias: "file", File.self, arguments: [
          "type": .variable("type"),
          "metadata": .variable("metadata")
        ]),
      ] }

      ///   Create a file with given type (extension) of the file. For example: to create an mp4 file in the system, use `createFile(type: 'mp4')` mutation.
      var file: File { __data["file"] }

      /// File
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