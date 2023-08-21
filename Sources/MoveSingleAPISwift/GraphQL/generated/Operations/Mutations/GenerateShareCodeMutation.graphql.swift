// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension MoveSingleGraphQL {
  class GenerateShareCodeMutation: GraphQLMutation {
    static let operationName: String = "GenerateShareCode"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation GenerateShareCode($fileId: String!) { shareCode: generateShareCode(fileId: $fileId) { __typename code } }"#
      ))

    public var fileId: String

    public init(fileId: String) {
      self.fileId = fileId
    }

    public var __variables: Variables? { ["fileId": fileId] }

    struct Data: MoveSingleGraphQL.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("generateShareCode", alias: "shareCode", ShareCode.self, arguments: ["fileId": .variable("fileId")]),
      ] }

      ///   Generate a share code for a job output. This is typically used to share the output of a job with other users (example: fbx and mp4 output files).
      var shareCode: ShareCode { __data["shareCode"] }

      /// ShareCode
      ///
      /// Parent Type: `ShareCode`
      struct ShareCode: MoveSingleGraphQL.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.ShareCode }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("code", String.self),
        ] }

        ///   Share code value.
        var code: String { __data["code"] }
      }
    }
  }

}