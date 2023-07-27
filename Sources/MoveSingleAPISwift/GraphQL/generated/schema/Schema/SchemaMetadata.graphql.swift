// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

protocol GraphQL_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == GraphQL.SchemaMetadata {}

protocol GraphQL_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == GraphQL.SchemaMetadata {}

protocol GraphQL_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == GraphQL.SchemaMetadata {}

protocol GraphQL_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == GraphQL.SchemaMetadata {}

extension GraphQL {
  typealias ID = String

  typealias SelectionSet = GraphQL_SelectionSet

  typealias InlineFragment = GraphQL_InlineFragment

  typealias MutableSelectionSet = GraphQL_MutableSelectionSet

  typealias MutableInlineFragment = GraphQL_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    static func objectType(forTypename typename: String) -> Object? {
      switch typename {
      case "Mutation": return GraphQL.Objects.Mutation
      case "File": return GraphQL.Objects.File
      case "Client": return GraphQL.Objects.Client
      case "Job": return GraphQL.Objects.Job
      case "Take": return GraphQL.Objects.Take
      case "ShareCode": return GraphQL.Objects.ShareCode
      case "Query": return GraphQL.Objects.Query
      case "AdditionalFile": return GraphQL.Objects.AdditionalFile
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}