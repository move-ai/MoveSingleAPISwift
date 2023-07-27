// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MoveSingleGraphQL

public class Job: MockObject {
  public static let objectType: Object = MoveSingleGraphQL.Objects.Job
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Job>>

  public struct MockFields {
    @Field<MoveSingleGraphQL.ID>("id") public var id
    @Field<[AdditionalFile?]>("outputs") public var outputs
    @Field<String>("state") public var state
  }
}

public extension Mock where O == Job {
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
