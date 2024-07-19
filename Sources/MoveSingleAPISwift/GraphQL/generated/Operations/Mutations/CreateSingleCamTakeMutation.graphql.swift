// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension MoveSingleGraphQL {
  class CreateSingleCamTakeMutation: GraphQLMutation {
    static let operationName: String = "CreateSingleCamTake"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation CreateSingleCamTake($sources: [SourceInput!], $metadata: AWSJSON!) { take: createSingleCamTake(sources: $sources, metadata: $metadata) { __typename id } }"#
      ))

    public var sources: GraphQLNullable<[SourceInput]>
    public var metadata: AWSJSON

    public init(
      sources: GraphQLNullable<[SourceInput]>,
      metadata: AWSJSON
    ) {
      self.sources = sources
      self.metadata = metadata
    }

    public var __variables: Variables? { [
      "sources": sources,
      "metadata": metadata
    ] }

    struct Data: MoveSingleGraphQL.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("createSingleCamTake", alias: "take", Take.self, arguments: [
          "sources": .variable("sources"),
          "metadata": .variable("metadata")
        ]),
      ] }

      ///   Create take from a single camera.
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