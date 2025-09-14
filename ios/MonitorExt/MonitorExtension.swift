import DeviceActivity
import os.log

final class MonitorExtension: DeviceActivityMonitor {
  override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityEventActivities) {
    let payload = MonitorEvent(configId: event.rawValue, type: "limit_reached", occurredAtEpochSec: Int(Date().timeIntervalSince1970))
    do {
      try MonitorEventStore.shared.append(payload)
    } catch {
      os_log("Failed to append event: %{public}@", "\(error)")
    }
  }
}
