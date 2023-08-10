// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
@testable import MoveSingleAPISwift

class File: MockObject {
  static let objectType: Object = MoveSingleGraphQL.Objects.File
  static let _mockFields = MockFields()
  typealias MockValueCollectionType = Array<Mock<File>>

  struct MockFields {
    @Field<MoveSingleGraphQL.ID>("id") public var id
    @Field<MoveSingleGraphQL.AWSURL>("presignedUrl") public var presignedUrl
  }
}

extension Mock where O == File {
  convenience init(
    id: MoveSingleGraphQL.ID? = nil,
    presignedUrl: MoveSingleGraphQL.AWSURL? = nil
  ) {
    self.init()
    _setScalar(id, for: \.id)
    _setScalar(presignedUrl, for: \.presignedUrl)
  }
}
