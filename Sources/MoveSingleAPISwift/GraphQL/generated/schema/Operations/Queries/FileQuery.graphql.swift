// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GraphQL {
  class FileQuery: GraphQLQuery {
    static let operationName: String = "File"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query File($fileId: ID!) { file: getFile(fileId: $fileId) { __typename id presignedUrl } }"#
      ))

    public var fileId: ID

    public init(fileId: ID) {
      self.fileId = fileId
    }

    public var __variables: Variables? { ["fileId": fileId] }

    struct Data: GraphQL.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { GraphQL.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("getFile", alias: "file", File.self, arguments: ["fileId": .variable("fileId")]),
      ] }

      ///   Get file details with given file id.
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