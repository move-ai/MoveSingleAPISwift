// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension MoveSingleGraphQL {
  ///   The source device, file and camera settings to use for a take.
  struct SourceInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      cameraSettings: GraphQLNullable<CameraSettingsInput> = nil,
      clipWindow: GraphQLNullable<ClipWindowInput> = nil,
      deviceLabel: String,
      fileId: String,
      format: GraphQLEnum<SourceFormat>
    ) {
      __data = InputDict([
        "cameraSettings": cameraSettings,
        "clipWindow": clipWindow,
        "deviceLabel": deviceLabel,
        "fileId": fileId,
        "format": format
      ])
    }

    ///   Settings for the camera that was used to capture this source.
    var cameraSettings: GraphQLNullable<CameraSettingsInput> {
      get { __data["cameraSettings"] }
      set { __data["cameraSettings"] = newValue }
    }

    ///   The clip window that should be processed. If not provided the entire source will be processed.
    var clipWindow: GraphQLNullable<ClipWindowInput> {
      get { __data["clipWindow"] }
      set { __data["clipWindow"] = newValue }
    }

    ///   A user defined label for the device this source input was captured on.
    var deviceLabel: String {
      get { __data["deviceLabel"] }
      set { __data["deviceLabel"] = newValue }
    }

    ///   Reference to the file object of this source.
    var fileId: String {
      get { __data["fileId"] }
      set { __data["fileId"] = newValue }
    }

    ///   The file format of the source.
    var format: GraphQLEnum<SourceFormat> {
      get { __data["format"] }
      set { __data["format"] = newValue }
    }
  }

}