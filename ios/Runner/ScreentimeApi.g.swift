// GENERATED CODE - DO NOT MODIFY BY HAND
// See pigeons/screentime.dart for input definitions.

import Foundation
import Flutter

class STThresholdConfig: NSObject {
  var configId: String?
  var bundleIds: [String?]?
  var secondsLimit: Int32?
  var schedule: String?

  static func fromMap(_ map: [AnyHashable: Any?]) -> STThresholdConfig {
    let result = STThresholdConfig()
    result.configId = map["configId"] as? String
    result.bundleIds = map["bundleIds"] as? [String?]
    result.secondsLimit = map["secondsLimit"] as? Int32
    result.schedule = map["schedule"] as? String
    return result
  }

  func toMap() -> [AnyHashable: Any?] {
    return [
      "configId": configId,
      "bundleIds": bundleIds,
      "secondsLimit": secondsLimit,
      "schedule": schedule,
    ]
  }
}

class STMonitorEvent: NSObject {
  var configId: String?
  var type: String?
  var occurredAtEpochSec: Int32?

  static func fromMap(_ map: [AnyHashable: Any?]) -> STMonitorEvent {
    let result = STMonitorEvent()
    result.configId = map["configId"] as? String
    result.type = map["type"] as? String
    result.occurredAtEpochSec = map["occurredAtEpochSec"] as? Int32
    return result
  }

  func toMap() -> [AnyHashable: Any?] {
    return [
      "configId": configId,
      "type": type,
      "occurredAtEpochSec": occurredAtEpochSec,
    ]
  }
}

protocol STScreentimeHostApi {
  func requestAuthorization() -> Bool
  func presentFamilyActivityPicker() -> Bool
  func hasSavedSelection() -> Bool
  func startMonitoring(_ cfg: STThresholdConfig) -> Bool
  func stopMonitoring(_ configId: String) -> Bool
  func readAndClearMonitorEvents() -> [STMonitorEvent?]
  func appGroupId() -> String
}

class STScreentimeHostApiSetup {
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: STScreentimeHostApi?) {
    let requestAuthorizationChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ScreentimeHostApi.requestAuthorization", binaryMessenger: binaryMessenger)
    if let api = api {
      requestAuthorizationChannel.setMessageHandler { _, reply in
        let result = api.requestAuthorization()
        reply([result])
      }
    } else {
      requestAuthorizationChannel.setMessageHandler(nil)
    }

    let presentPickerChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ScreentimeHostApi.presentFamilyActivityPicker", binaryMessenger: binaryMessenger)
    if let api = api {
      presentPickerChannel.setMessageHandler { _, reply in
        let result = api.presentFamilyActivityPicker()
        reply([result])
      }
    } else {
      presentPickerChannel.setMessageHandler(nil)
    }

    let hasSelectionChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ScreentimeHostApi.hasSavedSelection", binaryMessenger: binaryMessenger)
    if let api = api {
      hasSelectionChannel.setMessageHandler { _, reply in
        let result = api.hasSavedSelection()
        reply([result])
      }
    } else {
      hasSelectionChannel.setMessageHandler(nil)
    }

    let startMonitoringChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ScreentimeHostApi.startMonitoring", binaryMessenger: binaryMessenger)
    if let api = api {
      startMonitoringChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let cfg = STThresholdConfig.fromMap(args[0] as! [AnyHashable: Any?])
        let result = api.startMonitoring(cfg)
        reply([result])
      }
    } else {
      startMonitoringChannel.setMessageHandler(nil)
    }

    let stopMonitoringChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ScreentimeHostApi.stopMonitoring", binaryMessenger: binaryMessenger)
    if let api = api {
      stopMonitoringChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let configId = args[0] as! String
        let result = api.stopMonitoring(configId)
        reply([result])
      }
    } else {
      stopMonitoringChannel.setMessageHandler(nil)
    }

    let readEventsChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ScreentimeHostApi.readAndClearMonitorEvents", binaryMessenger: binaryMessenger)
    if let api = api {
      readEventsChannel.setMessageHandler { _, reply in
        let result = api.readAndClearMonitorEvents().map { $0?.toMap() }
        reply([result])
      }
    } else {
      readEventsChannel.setMessageHandler(nil)
    }

    let appGroupChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ScreentimeHostApi.appGroupId", binaryMessenger: binaryMessenger)
    if let api = api {
      appGroupChannel.setMessageHandler { _, reply in
        let result = api.appGroupId()
        reply([result])
      }
    } else {
      appGroupChannel.setMessageHandler(nil)
    }
  }
}
