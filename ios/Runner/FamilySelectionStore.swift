import Foundation
import FamilyControls
import ManagedSettings
import os.log

final class FamilySelectionStore {
  static let shared = FamilySelectionStore()
  private let key = "familySelection"
  private let store = ManagedSettingsStore()

  func hasSelection() -> Bool {
    return AppGroup.userDefaults?.data(forKey: key) != nil
  }

  func save(selection: FamilyActivitySelection) throws {
    do {
      let data = try NSKeyedArchiver.archivedData(withRootObject: selection, requiringSecureCoding: true)
      AppGroup.userDefaults?.set(data, forKey: key)
      store.shield.applications = selection.applications
      store.shield.applicationCategories = selection.applicationCategories
    } catch {
      os_log("Failed to save selection: %{public}@", "\(error)")
      throw error
    }
  }

  func load() -> FamilyActivitySelection? {
    guard let data = AppGroup.userDefaults?.data(forKey: key) else { return nil }
    return try? NSKeyedUnarchiver.unarchivedObject(ofClass: FamilyActivitySelection.self, from: data)
  }
}
