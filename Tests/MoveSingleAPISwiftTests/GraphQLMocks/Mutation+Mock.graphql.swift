// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
@testable import MoveSingleAPISwift

class Mutation: MockObject {
  static let objectType: Object = MoveSingleGraphQL.Objects.Mutation
  static let _mockFields = MockFields()
  typealias MockValueCollectionType = Array<Mock<Mutation>>

  struct MockFields {
    @Field<File>("file") public var file
    @Field<Job>("job") public var job
    @Field<ShareCode>("shareCode") public var shareCode
    @Field<Take>("take") public var take
  }
}

extension Mock where O == Mutation {
  convenience init(
    file: Mock<File>? = nil,
    job: Mock<Job>? = nil,
    shareCode: Mock<ShareCode>? = nil,
    take: Mock<Take>? = nil
  ) {
    self.init()
    _setEntity(file, for: \.file)
    _setEntity(job, for: \.job)
    _setEntity(shareCode, for: \.shareCode)
    _setEntity(take, for: \.take)
  }
}
