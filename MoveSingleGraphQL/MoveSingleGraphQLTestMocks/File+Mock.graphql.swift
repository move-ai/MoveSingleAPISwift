// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MoveSingleGraphQL

public class File: MockObject {
  public static let objectType: Object = MoveSingleGraphQL.Objects.File
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<File>>

  public struct MockFields {
    @Field<MoveSingleGraphQL.ID>("id") public var id
    @Field<MoveSingleGraphQL.AWSURL>("presignedUrl") public var presignedUrl
  }
}

public extension Mock where O == File {
  convenience init(
    id: MoveSingleGraphQL.ID? = nil,
    presignedUrl: MoveSingleGraphQL.AWSURL? = nil
  ) {
    self.init()
    _setScalar(id, for: \.id)
    _setScalar(presignedUrl, for: \.presignedUrl)
  }
}
