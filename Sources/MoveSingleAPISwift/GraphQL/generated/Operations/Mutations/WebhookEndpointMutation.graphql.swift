// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension MoveSingleGraphQL {
  class WebhookEndpointMutation: GraphQLMutation {
    static let operationName: String = "WebhookEndpoint"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation WebhookEndpoint($events: [String!], $uid: String!, $url: String!) { upsertWebhookEndpoint(url: $url, uid: $uid, events: $events) { __typename events } }"#
      ))

    public var events: GraphQLNullable<[String]>
    public var uid: String
    public var url: String

    public init(
      events: GraphQLNullable<[String]>,
      uid: String,
      url: String
    ) {
      self.events = events
      self.uid = uid
      self.url = url
    }

    public var __variables: Variables? { [
      "events": events,
      "uid": uid,
      "url": url
    ] }

    struct Data: MoveSingleGraphQL.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("upsertWebhookEndpoint", UpsertWebhookEndpoint.self, arguments: [
          "url": .variable("url"),
          "uid": .variable("uid"),
          "events": .variable("events")
        ]),
      ] }

      ///   Perform an upsert operation on a webhook endpoint.
      var upsertWebhookEndpoint: UpsertWebhookEndpoint { __data["upsertWebhookEndpoint"] }

      /// UpsertWebhookEndpoint
      ///
      /// Parent Type: `WebhookEndpoint`
      struct UpsertWebhookEndpoint: MoveSingleGraphQL.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.WebhookEndpoint }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("events", [String]?.self),
        ] }

        ///   Events to be subscribed to. This is required to perform an upsert operation.
        var events: [String]? { __data["events"] }
      }
    }
  }

}