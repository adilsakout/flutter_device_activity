import Foundation
import os.log

enum AppGroup {
  static let id = "group.COM.YOUR.COMPANY.YOUR_APP.SHARED"

  static var userDefaults: UserDefaults? {
    UserDefaults(suiteName: id)
  }

  static func eventsURL() throws -> URL {
    if let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: id) {
      return container.appendingPathComponent("events.json")
    } else {
      // Fallback for unit tests
      os_log("App group container not found, using temporary directory")
      return FileManager.default.temporaryDirectory.appendingPathComponent("events.json")
    }
  }
}
