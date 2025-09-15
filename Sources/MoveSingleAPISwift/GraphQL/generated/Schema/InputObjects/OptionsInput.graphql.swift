// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension MoveSingleGraphQL {
  ///   Options input for a job
  struct OptionsInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      floorPlane: GraphQLNullable<Bool> = nil,
      mocapModel: GraphQLNullable<GraphQLEnum<MocapModelOptionsInput>> = nil,
      trackBall: GraphQLNullable<Bool> = nil,
      trackFingers: GraphQLNullable<Bool> = nil,
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
    var mocapModel: GraphQLNullable<GraphQLEnum<MocapModelOptionsInput>> {
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