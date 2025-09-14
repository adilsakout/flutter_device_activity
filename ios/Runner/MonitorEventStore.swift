import Foundation
import os.log

public struct MonitorEvent: Codable {
  public let configId: String
  public let type: String
  public let occurredAtEpochSec: Int
}

final class MonitorEventStore {
  static let shared = MonitorEventStore()
  private let queue = DispatchQueue(label: "MonitorEventStoreQueue")

  func append(_ event: MonitorEvent) throws {
    try queue.sync {
      var events = try load()
      events.append(event)
      let data = try JSONEncoder().encode(events)
      let url = try AppGroup.eventsURL()
      try data.write(to: url, options: .atomic)
    }
  }

  func readAndClear() throws -> [MonitorEvent] {
    return try queue.sync {
      let events = try load()
      let url = try AppGroup.eventsURL()
      try JSONEncoder().encode([MonitorEvent]()).write(to: url, options: .atomic)
      return events
    }
  }

  private func load() throws -> [MonitorEvent] {
    let url = try AppGroup.eventsURL()
    guard let data = try? Data(contentsOf: url) else { return [] }
    return try JSONDecoder().decode([MonitorEvent].self, from: data)
  }
}
