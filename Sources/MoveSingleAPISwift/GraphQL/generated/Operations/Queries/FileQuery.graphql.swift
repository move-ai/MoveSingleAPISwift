// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension MoveSingleGraphQL.Objects {
  /// One possible value for a given Enum. Enum values are unique values, not a placeholder for a string or numeric value. However an Enum value is returned in a JSON response as a string.
  static let __EnumValue = Object(
    typename: "__EnumValue",
    implementedInterfaces: []
  )
}

extension MoveSingleGraphQL.Objects {
  /// The fundamental unit of any GraphQL Schema is the type. There are many kinds of types in GraphQL as represented by the `__TypeKind` enum.
  ///
  /// Depending on the kind of a type, certain fields describe information about that type. Scalar types provide no information beyond a name, description and optional `specifiedByURL`, while Enum types provide their values. Object and Interface types provide the fields they describe. Abstract types, Union and Interface, provide the Object types possible at runtime. List and NonNull types compose other types.
  static let __Type = Object(
    typename: "__Type",
    implementedInterfaces: []
  )
}

extension MoveSingleGraphQL {
  class EnumsQuery: GraphQLQuery {
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

extension MoveSingleGraphQL {
  class FileQuery: GraphQLQuery {
    static let operationName: String = "File"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query File($fileId: ID!) { file: getFile(fileId: $fileId) { __typename id presignedUrl } }"#
      ))

    public var fileId: ID

    public init(fileId: ID) {
      self.fileId = fileId
    }

    public var __variables: Variables? { ["fileId": fileId] }

    struct Data: MoveSingleGraphQL.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("getFile", alias: "file", File.self, arguments: ["fileId": .variable("fileId")]),
      ] }

      ///   Get file details with given file id.
      var file: File { __data["file"] }

      /// File
      ///
      /// Parent Type: `File`
      struct File: MoveSingleGraphQL.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.File }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", MoveSingleGraphQL.ID.self),
          .field("presignedUrl", MoveSingleGraphQL.AWSURL?.self),
        ] }

        ///   Unique identifier for a File.
        var id: MoveSingleGraphQL.ID { __data["id"] }
        ///   Url to upload/download the file. When creating a file, this attribute will return a upload url. Otherwise, this attribute will represent a download url.
        var presignedUrl: MoveSingleGraphQL.AWSURL? { __data["presignedUrl"] }
      }
    }
  }

}
