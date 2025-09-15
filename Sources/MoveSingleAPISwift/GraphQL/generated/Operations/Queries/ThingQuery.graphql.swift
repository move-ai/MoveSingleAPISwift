// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension MoveSingleGraphQL {
  class ThingQuery: GraphQLQuery {
    static let operationName: String = "Thing"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query Thing { __type(name: "MocapModelOptionsInput") { __typename enumValues { __typename name } } }"#
      ))

    public init() {}

    struct Data: MoveSingleGraphQL.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__type", __Type?.self, arguments: ["name": "MocapModelOptionsInput"]),
      ] }

      var __type: __Type? { __data["__type"] }

      /// __Type
      ///
      /// Parent Type: `__Type`
      struct __Type: MoveSingleGraphQL.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.__Type }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("enumValues", [EnumValue]?.self),
        ] }

        var enumValues: [EnumValue]? { __data["enumValues"] }

        /// __Type.EnumValue
        ///
        /// Parent Type: `__EnumValue`
        struct EnumValue: MoveSingleGraphQL.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.__EnumValue }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("name", String.self),
          ] }

          var name: String { __data["name"] }
        }
      }
    }
  }

}