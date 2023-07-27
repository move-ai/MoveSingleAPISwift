// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class TakeQuery: GraphQLQuery {
  public static let operationName: String = "Take"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Take($takeId: ID!) { take: getTake(takeId: $takeId) { __typename id } }"#
    ))

  public var takeId: ID

  public init(takeId: ID) {
    self.takeId = takeId
  }

  public var __variables: Variables? { ["takeId": takeId] }

  public struct Data: MoveSingleGraphQL.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getTake", alias: "take", Take.self, arguments: ["takeId": .variable("takeId")]),
    ] }

    ///   Get a take with give id.
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
