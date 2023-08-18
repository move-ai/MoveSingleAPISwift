// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
@testable import MoveSingleAPISwift

class ShareCode: MockObject {
  static let objectType: Object = MoveSingleGraphQL.Objects.ShareCode
  static let _mockFields = MockFields()
  typealias MockValueCollectionType = Array<Mock<ShareCode>>

  struct MockFields {
    @Field<String>("code") public var code
  }
}

extension Mock where O == ShareCode {
  convenience init(
    code: String? = nil
  ) {
    self.init()
    _setScalar(code, for: \.code)
  }
}
