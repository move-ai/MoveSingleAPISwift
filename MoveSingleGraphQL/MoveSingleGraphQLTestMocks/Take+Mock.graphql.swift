// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MoveSingleGraphQL

public class Take: MockObject {
  public static let objectType: Object = MoveSingleGraphQL.Objects.Take
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Take>>

  public struct MockFields {
    @Field<MoveSingleGraphQL.ID>("id") public var id
  }
}

public extension Mock where O == Take {
  convenience init(
    id: MoveSingleGraphQL.ID? = nil
  ) {
    self.init()
    _setScalar(id, for: \.id)
  }
}
