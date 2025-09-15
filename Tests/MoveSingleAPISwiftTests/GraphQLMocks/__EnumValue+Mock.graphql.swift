// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MoveSingleAPISwift

class __EnumValue: MockObject {
  static let objectType: Object = MoveSingleGraphQL.Objects.__EnumValue
  static let _mockFields = MockFields()
  typealias MockValueCollectionType = Array<Mock<__EnumValue>>

  struct MockFields {
    @Field<String>("name") public var name
  }
}

extension Mock where O == __EnumValue {
  convenience init(
    name: String? = nil
  ) {
    self.init()
    _setScalar(name, for: \.name)
  }
}
