// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension MoveSingleGraphQL {
  ///   The start and end time of the clip window that should be processed. startTime should be before endTime.
  struct ClipWindowInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      endTime: Double,
      startTime: Double
    ) {
      __data = InputDict([
        "endTime": endTime,
        "startTime": startTime
      ])
    }

    ///   The end time of the clip window to be processed.
    var endTime: Double {
      get { __data["endTime"] }
      set { __data["endTime"] = newValue }
    }

    ///   The start time of the clip window to be processed.
    var startTime: Double {
      get { __data["startTime"] }
      set { __data["startTime"] = newValue }
    }
  }

}