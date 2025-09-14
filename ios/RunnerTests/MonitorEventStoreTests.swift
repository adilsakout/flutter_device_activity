import XCTest
@testable import Runner

final class MonitorEventStoreTests: XCTestCase {
  func testAppendReadClear() throws {
    let event = MonitorEvent(configId: "abc", type: "limit_reached", occurredAtEpochSec: 1)
    try MonitorEventStore.shared.append(event)
    let events = try MonitorEventStore.shared.readAndClear()
    XCTAssertEqual(events.count, 1)
    XCTAssertEqual(events.first?.configId, "abc")
    let empty = try MonitorEventStore.shared.readAndClear()
    XCTAssertTrue(empty.isEmpty)
  }
}
