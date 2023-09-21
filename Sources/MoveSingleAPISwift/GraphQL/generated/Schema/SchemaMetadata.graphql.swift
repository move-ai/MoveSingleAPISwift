// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

protocol MoveSingleGraphQL_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == MoveSingleGraphQL.SchemaMetadata {}

protocol MoveSingleGraphQL_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == MoveSingleGraphQL.SchemaMetadata {}

protocol MoveSingleGraphQL_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == MoveSingleGraphQL.SchemaMetadata {}

protocol MoveSingleGraphQL_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == MoveSingleGraphQL.SchemaMetadata {}

extension MoveSingleGraphQL {
  typealias ID = String

  typealias SelectionSet = MoveSingleGraphQL_SelectionSet

  typealias InlineFragment = MoveSingleGraphQL_InlineFragment

  typealias MutableSelectionSet = MoveSingleGraphQL_MutableSelectionSet

  typealias MutableInlineFragment = MoveSingleGraphQL_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    static func objectType(forTypename typename: String) -> Object? {
      switch typename {
      case "Mutation": return MoveSingleGraphQL.Objects.Mutation
      case "File": return MoveSingleGraphQL.Objects.File
      case "Client": return MoveSingleGraphQL.Objects.Client
      case "Job": return MoveSingleGraphQL.Objects.Job
      case "Take": return MoveSingleGraphQL.Objects.Take
      case "ShareCode": return MoveSingleGraphQL.Objects.ShareCode
      case "Query": return MoveSingleGraphQL.Objects.Query
      case "AdditionalFile": return MoveSingleGraphQL.Objects.AdditionalFile
      case "WebhookEndpoint": return MoveSingleGraphQL.Objects.WebhookEndpoint
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}