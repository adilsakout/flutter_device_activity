import XCTest
@testable import Runner
import FamilyControls

class MockAuthorizationCenter: AuthorizationCenterProtocol {
  var invoked = false
  func requestAuthorization(for: AuthorizationType) async throws {
    invoked = true
  }
}

final class AuthorizationCenterTests: XCTestCase {
  func testRequestAuthorization() {
    let mock = MockAuthorizationCenter()
    let api = ScreentimeHostApiImpl(authCenter: mock)
    XCTAssertTrue(api.requestAuthorization())
    XCTAssertTrue(mock.invoked)
  }
}
