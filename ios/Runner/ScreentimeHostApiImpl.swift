import FamilyControls
import DeviceActivity
import ManagedSettings
import SwiftUI
import os.log

protocol AuthorizationCenterProtocol {
  func requestAuthorization(for: AuthorizationType) async throws
}

extension AuthorizationCenter: AuthorizationCenterProtocol {}

class ScreentimeHostApiImpl: STScreentimeHostApi {
  private let authCenter: AuthorizationCenterProtocol

  init(authCenter: AuthorizationCenterProtocol = AuthorizationCenter.shared) {
    self.authCenter = authCenter
  }

  func requestAuthorization() -> Bool {
    var success = false
    let group = DispatchGroup()
    group.enter()
    Task {
      do {
        try await authCenter.requestAuthorization(for: .individual)
        success = true
      } catch {
        os_log("Authorization failed: %{public}@", "\(error)")
      }
      group.leave()
    }
    group.wait()
    return success
  }

  func presentFamilyActivityPicker() -> Bool {
    guard let controller = UIApplication.shared.windows.first?.rootViewController else {
      return false
    }
    let picker = FamilyActivityPicker { selection in
      do {
        try FamilySelectionStore.shared.save(selection: selection)
      } catch {
        os_log("Save selection error: %{public}@", "\(error)")
      }
      controller.dismiss(animated: true)
    }
    let host = UIHostingController(rootView: picker)
    controller.present(host, animated: true)
    return true
  }

  func hasSavedSelection() -> Bool {
    return FamilySelectionStore.shared.hasSelection()
  }

  func startMonitoring(_ cfg: STThresholdConfig) -> Bool {
    guard let id = cfg.configId, let limit = cfg.secondsLimit else { return false }
    let schedule: DeviceActivitySchedule
    switch cfg.schedule {
    case "weekly":
      schedule = DeviceActivitySchedule(repeating: .weekly, intervalStart: DateComponents(hour: 0), intervalEnd: DateComponents(hour: 23, minute: 59))
    default:
      schedule = DeviceActivitySchedule(repeating: .daily, intervalStart: DateComponents(hour: 0), intervalEnd: DateComponents(hour: 23, minute: 59))
    }
    let eventName = DeviceActivityEvent.Name(id)
    let event = DeviceActivityEvent(threshold: DateComponents(second: limit))
    do {
      try DeviceActivityCenter.shared.startMonitoring(eventName, during: schedule, events: [eventName: event])
      return true
    } catch {
      os_log("startMonitoring error: %{public}@", "\(error)")
      return false
    }
  }

  func stopMonitoring(_ configId: String) -> Bool {
    let name = DeviceActivityEvent.Name(configId)
    do {
      try DeviceActivityCenter.shared.stopMonitoring([name])
      return true
    } catch {
      os_log("stopMonitoring error: %{public}@", "\(error)")
      return false
    }
  }

  func readAndClearMonitorEvents() -> [STMonitorEvent?] {
    do {
      return try MonitorEventStore.shared.readAndClear().map { event in
        let e = STMonitorEvent()
        e.configId = event.configId
        e.type = event.type
        e.occurredAtEpochSec = Int32(event.occurredAtEpochSec)
        return e
      }
    } catch {
      os_log("readAndClear error: %{public}@", "\(error)")
      return []
    }
  }

  func appGroupId() -> String {
    return AppGroup.id
  }
}
