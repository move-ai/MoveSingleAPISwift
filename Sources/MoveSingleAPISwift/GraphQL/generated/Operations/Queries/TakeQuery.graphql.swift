// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension MoveSingleGraphQL {
  class TakeQuery: GraphQLQuery {
    static let operationName: String = "Take"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query Take($takeId: ID!) { take: getTake(takeId: $takeId) { __typename id } }"#
      ))

    public var takeId: ID

    public init(takeId: ID) {
      self.takeId = takeId
    }

    public var __variables: Variables? { ["takeId": takeId] }

    struct Data: MoveSingleGraphQL.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("getTake", alias: "take", Take.self, arguments: ["takeId": .variable("takeId")]),
      ] }

      ///   Get a take with give id.
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