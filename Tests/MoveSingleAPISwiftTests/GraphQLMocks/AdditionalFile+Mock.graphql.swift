// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
@testable import MoveSingleAPISwift

class AdditionalFile: MockObject {
  static let objectType: Object = MoveSingleGraphQL.Objects.AdditionalFile
  static let _mockFields = MockFields()
  typealias MockValueCollectionType = Array<Mock<AdditionalFile>>

  struct MockFields {
    @Field<File>("file") public var file
    @Field<String>("key") public var key
  }
}

extension Mock where O == AdditionalFile {
  convenience init(
    file: Mock<File>? = nil,
    key: String? = nil
  ) {
    self.init()
    _setEntity(file, for: \.file)
    _setScalar(key, for: \.key)
  }
}
