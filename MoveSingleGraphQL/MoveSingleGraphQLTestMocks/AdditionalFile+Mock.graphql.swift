// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MoveSingleGraphQL

public class AdditionalFile: MockObject {
  public static let objectType: Object = MoveSingleGraphQL.Objects.AdditionalFile
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<AdditionalFile>>

  public struct MockFields {
    @Field<File>("file") public var file
    @Field<String>("key") public var key
  }
}

public extension Mock where O == AdditionalFile {
  convenience init(
    file: Mock<File>? = nil,
    key: String? = nil
  ) {
    self.init()
    _setEntity(file, for: \.file)
    _setScalar(key, for: \.key)
  }
}
