// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension MoveSingleGraphQL {
  ///   Options input for a job
  struct OptionsInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      floorPlane: GraphQLNullable<Bool> = true,
      //mocapModel: GraphQLNullable<GraphQLEnum<MocapModelOptionsInput>> = nil,
      mocapModel: GraphQLNullable<String> = nil,
      trackBall: GraphQLNullable<Bool> = nil,
      trackFingers: GraphQLNullable<Bool> = true,
      trackJerseyNumbers: GraphQLNullable<Bool> = nil
    ) {
      __data = InputDict([
        "floorPlane": floorPlane,
        "mocapModel": mocapModel,
        "trackBall": trackBall,
        "trackFingers": trackFingers,
        "trackJerseyNumbers": trackJerseyNumbers
      ])
    }

    ///   Floor Plane
    var floorPlane: GraphQLNullable<Bool> {
      get { __data["floorPlane"] }
      set { __data["floorPlane"] = newValue }
    }

    ///   Mocap Model
    //var mocapModel: GraphQLNullable<GraphQLEnum<MocapModelOptionsInput>> {
    var mocapModel: GraphQLNullable<String> {
      get { __data["mocapModel"] }
      set { __data["mocapModel"] = newValue }
    }

    ///   Track Ball
    var trackBall: GraphQLNullable<Bool> {
      get { __data["trackBall"] }
      set { __data["trackBall"] = newValue }
    }

    ///   Track Fingers
    var trackFingers: GraphQLNullable<Bool> {
      get { __data["trackFingers"] }
      set { __data["trackFingers"] = newValue }
    }

    ///   Track Jersey Numbers
    var trackJerseyNumbers: GraphQLNullable<Bool> {
      get { __data["trackJerseyNumbers"] }
      set { __data["trackJerseyNumbers"] = newValue }
    }
  }

}

extension MoveSingleGraphQL {
  class CreateSingleCamJobMutation: GraphQLMutation {
    static let operationName: String = "CreateSingleCamJob"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation CreateSingleCamJob($takeId: String!, $metadata: AWSJSON!, $options: OptionsInput!) { job: createSingleCamJob(takeId: $takeId, metadata: $metadata, options: $options) { __typename id state } }"#
      ))

    public var takeId: String
    public var metadata: AWSJSON
    public var options: OptionsInput

    public init(
      takeId: String,
      metadata: AWSJSON,
      options: OptionsInput
    ) {
      self.takeId = takeId
      self.metadata = metadata
      self.options = options
    }

    public var __variables: Variables? { [
      "takeId": takeId,
      "metadata": metadata,
      "options": options
    ] }

    struct Data: MoveSingleGraphQL.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("createSingleCamJob", alias: "job", Job.self, arguments: [
          "takeId": .variable("takeId"),
          "metadata": .variable("metadata"),
          "options": .variable("options")
        ]),
      ] }

      ///   Initialize processing a job to generate animation from a take.
      var job: Job { __data["job"] }

      /// Job
      ///
      /// Parent Type: `Job`
      struct Job: MoveSingleGraphQL.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { MoveSingleGraphQL.Objects.Job }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", MoveSingleGraphQL.ID.self),
          .field("state", String?.self),
        ] }

        ///   Unique identifier for the job
        var id: MoveSingleGraphQL.ID { __data["id"] }
        ///   Current status of the job
        var state: String? { __data["state"] }
      }
    }
  }

}

