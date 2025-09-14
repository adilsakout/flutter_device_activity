import Foundation
import os.log

final class BackgroundUploader {
  static let shared = BackgroundUploader()

  func upload(events: [MonitorEvent]) {
    // TODO: Replace with your backend URL and auth token.
    os_log("Uploading %d events to backend (placeholder)", events.count)
  }
}
