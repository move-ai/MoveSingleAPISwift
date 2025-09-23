// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension MoveSingleGraphQL {
  class CreateTakeMutation: GraphQLMutation {
    static let operationName: String = "CreateTake"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation CreateTake($videoFileId: String!, $moveFileId: String!, $metadata: AWSJSON!) { take: createTake( videoFileId: $videoFileId additionalFileIds: [{key: MOVE, fileId: $moveFileId}] metadata: $metadata ) { __typename id } }"#
      ))

    public var videoFileId: String
    public var moveFileId: String
    public var metadata: AWSJSON

    public init(
      videoFileId: String,
      moveFileId: String,
      metadata: AWSJSON
    ) {
      self.videoFileId = videoFileId
      self.moveFileId = moveFileId
      self.metadata = metadata
    }

    public var __variables: Variables? { [
      "videoFileId": videoFileId,
      "moveFileId": moveFileId,
      "metadata": metadata
    ] }

    struct Data: MoveSingleGraphQL.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("createTake", alias: "take", Take.self, arguments: [
          "videoFileId": .variable("videoFileId"),
          "additionalFileIds": [[
            "key": "MOVE",
            "fileId": .variable("moveFileId")
          ]],
          "metadata": .variable("metadata")
        ]),
      ] }

      ///   Create a take from an existing file.
      var take: Take { __data["take"] }

      /// Take
      ///
      /// Parent Type: `Take`
      struct Take: MoveSingleGraphQL.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.Take }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", MoveSingleGraphQL.ID.self),
        ] }

        ///    Unique id of a take 
        var id: MoveSingleGraphQL.ID { __data["id"] }
      }
    }
  }

}