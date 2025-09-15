// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MoveSingleAPISwift

class Query: MockObject {
  static let objectType: Object = MoveSingleGraphQL.Objects.Query
  static let _mockFields = MockFields()
  typealias MockValueCollectionType = Array<Mock<Query>>

  struct MockFields {
    @Field<__Type>("__type") public var __type
    @Field<File>("file") public var file
    @Field<Job>("job") public var job
    @Field<Take>("take") public var take
  }
}

extension Mock where O == Query {
  convenience init(
    __type: Mock<__Type>? = nil,
    file: Mock<File>? = nil,
    job: Mock<Job>? = nil,
    take: Mock<Take>? = nil
  ) {
    self.init()
    _setEntity(__type, for: \.__type)
    _setEntity(file, for: \.file)
    _setEntity(job, for: \.job)
    _setEntity(take, for: \.take)
  }
}
