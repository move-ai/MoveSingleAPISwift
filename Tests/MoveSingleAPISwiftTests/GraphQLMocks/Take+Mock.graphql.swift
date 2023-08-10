// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
@testable import MoveSingleAPISwift

class Take: MockObject {
  static let objectType: Object = MoveSingleGraphQL.Objects.Take
  static let _mockFields = MockFields()
  typealias MockValueCollectionType = Array<Mock<Take>>

  struct MockFields {
    @Field<MoveSingleGraphQL.ID>("id") public var id
  }
}

extension Mock where O == Take {
  convenience init(
    id: MoveSingleGraphQL.ID? = nil
  ) {
    self.init()
    _setScalar(id, for: \.id)
  }
}
