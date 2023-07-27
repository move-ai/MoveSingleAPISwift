// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CreateTakeMutation: GraphQLMutation {
  public static let operationName: String = "CreateTake"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CreateTake($videoFileId: String!, $moveFileId: String!) { take: createTake( videoFileId: $videoFileId additionalFileIds: [{key: MOVE, fileId: $moveFileId}] ) { __typename id } }"#
    ))

  public var videoFileId: String
  public var moveFileId: String

  public init(
    videoFileId: String,
    moveFileId: String
  ) {
    self.videoFileId = videoFileId
    self.moveFileId = moveFileId
  }

  public var __variables: Variables? { [
    "videoFileId": videoFileId,
    "moveFileId": moveFileId
  ] }

  public struct Data: MoveSingleGraphQL.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("createTake", alias: "take", Take.self, arguments: [
        "videoFileId": .variable("videoFileId"),
        "additionalFileIds": [[
          "key": "MOVE",
          "fileId": .variable("moveFileId")
        ]]
      ]),
    ] }

    ///   Create a take from an existing file.
    public var take: Take { __data["take"] }

    /// Take
    ///
    /// Parent Type: `Take`
    public struct Take: MoveSingleGraphQL.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.Take }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", MoveSingleGraphQL.ID.self),
      ] }

      ///    Unique id of a take 
      public var id: MoveSingleGraphQL.ID { __data["id"] }
    }
  }
}
