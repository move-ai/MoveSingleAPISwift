// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
@testable import MoveSingleAPISwift

class WebhookEndpoint: MockObject {
  static let objectType: Object = MoveSingleGraphQL.Objects.WebhookEndpoint
  static let _mockFields = MockFields()
  typealias MockValueCollectionType = Array<Mock<WebhookEndpoint>>

  struct MockFields {
    @Field<[String]>("events") public var events
  }
}

extension Mock where O == WebhookEndpoint {
  convenience init(
    events: [String]? = nil
  ) {
    self.init()
    _setScalarList(events, for: \.events)
  }
}
