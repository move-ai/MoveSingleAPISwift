// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
@testable import MoveSingleAPISwift

class Job: MockObject {
  static let objectType: Object = MoveSingleGraphQL.Objects.Job
  static let _mockFields = MockFields()
  typealias MockValueCollectionType = Array<Mock<Job>>

  struct MockFields {
    @Field<MoveSingleGraphQL.ID>("id") public var id
    @Field<[AdditionalFile?]>("outputs") public var outputs
    @Field<String>("state") public var state
  }
}

extension Mock where O == Job {
  convenience init(
    id: MoveSingleGraphQL.ID? = nil,
    outputs: [Mock<AdditionalFile>?]? = nil,
    state: String? = nil
  ) {
    self.init()
    _setScalar(id, for: \.id)
    _setList(outputs, for: \.outputs)
    _setScalar(state, for: \.state)
  }
}
