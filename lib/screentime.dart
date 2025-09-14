import 'screentime_api.pigeon.dart';

/// Flutter-facing wrapper for Screen Time APIs on iOS.
class Screentime {
  ScreentimeHostApi get _api => ScreentimeHostApi();

  Future<bool> requestAuthorization() => _api.requestAuthorization();
  Future<bool> presentPicker() => _api.presentFamilyActivityPicker();
  Future<bool> hasSavedSelection() => _api.hasSavedSelection();

  Future<bool> startMonitoring({
    required String configId,
    required List<String> bundleIds,
    required int secondsLimit,
    required String schedule,
  }) {
    final cfg = ThresholdConfig()
      ..configId = configId
      ..bundleIds = bundleIds
      ..secondsLimit = secondsLimit
      ..schedule = schedule;
    return _api.startMonitoring(cfg);
  }

  Future<bool> stopMonitoring(String configId) => _api.stopMonitoring(configId);

  Future<List<MonitorEvent?>> readAndClearMonitorEvents() => _api.readAndClearMonitorEvents();

  Future<String> appGroupId() => _api.appGroupId();
}
