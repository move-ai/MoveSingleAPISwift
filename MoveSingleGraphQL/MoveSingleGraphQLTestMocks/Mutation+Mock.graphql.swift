// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MoveSingleGraphQL

public class Mutation: MockObject {
  public static let objectType: Object = MoveSingleGraphQL.Objects.Mutation
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Mutation>>

  public struct MockFields {
    @Field<File>("file") public var file
    @Field<Job>("job") public var job
    @Field<Take>("take") public var take
  }
}

public extension Mock where O == Mutation {
  convenience init(
    file: Mock<File>? = nil,
    job: Mock<Job>? = nil,
    take: Mock<Take>? = nil
  ) {
    self.init()
    _setEntity(file, for: \.file)
    _setEntity(job, for: \.job)
    _setEntity(take, for: \.take)
  }
}
