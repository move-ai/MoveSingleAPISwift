// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public typealias ID = String

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == MoveSingleGraphQL.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == MoveSingleGraphQL.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == MoveSingleGraphQL.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == MoveSingleGraphQL.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> Object? {
    switch typename {
    case "Mutation": return MoveSingleGraphQL.Objects.Mutation
    case "File": return MoveSingleGraphQL.Objects.File
    case "Client": return MoveSingleGraphQL.Objects.Client
    case "Job": return MoveSingleGraphQL.Objects.Job
    case "Take": return MoveSingleGraphQL.Objects.Take
    case "ShareCode": return MoveSingleGraphQL.Objects.ShareCode
    case "Query": return MoveSingleGraphQL.Objects.Query
    case "AdditionalFile": return MoveSingleGraphQL.Objects.AdditionalFile
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
