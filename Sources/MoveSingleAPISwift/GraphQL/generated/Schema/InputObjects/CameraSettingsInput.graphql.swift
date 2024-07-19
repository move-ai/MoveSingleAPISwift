// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension MoveSingleGraphQL {
  ///   The camera settings for the source input.
  struct CameraSettingsInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      lens: String
    ) {
      __data = InputDict([
        "lens": lens
      ])
    }

    ///   The name of the lens that was used to create the capture inputs.
    var lens: String {
      get { __data["lens"] }
      set { __data["lens"] = newValue }
    }
  }

}