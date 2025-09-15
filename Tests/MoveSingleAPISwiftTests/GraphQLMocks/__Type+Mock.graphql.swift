// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MoveSingleAPISwift

class __Type: MockObject {
  static let objectType: Object = MoveSingleGraphQL.Objects.__Type
  static let _mockFields = MockFields()
  typealias MockValueCollectionType = Array<Mock<__Type>>

  struct MockFields {
    @Field<[__EnumValue]>("enumValues") public var enumValues
  }
}

extension Mock where O == __Type {
  convenience init(
    enumValues: [Mock<__EnumValue>]? = nil
  ) {
    self.init()
    _setList(enumValues, for: \.enumValues)
  }
}
