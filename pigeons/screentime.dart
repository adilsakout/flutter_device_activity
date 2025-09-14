import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  dartOut: 'lib/screentime_api.pigeon.dart',
  swiftOut: 'ios/Runner/ScreentimeApi.g.swift',
  swiftOptions: SwiftOptions(prefix: 'ST'),
)
class ThresholdConfig {
  String? configId;          // uuid
  List<String?>? bundleIds;  // app bundle IDs
  int? secondsLimit;         // e.g., 3600
  String? schedule;          // e.g., "daily", "weekly"
}

class MonitorEvent {
  String? configId;
  String? type;              // "limit_reached" | "goal_met" | "reset"
  int? occurredAtEpochSec;
}

@HostApi()
abstract class ScreentimeHostApi {
  // Phase 1: Entitlements + Authorization
  bool requestAuthorization(); // FamilyControls.AuthorizationCenter
    
  // Phase 2: Selection
  bool presentFamilyActivityPicker(); // opens the native picker UI
  bool hasSavedSelection();
  
  // Phase 4: Monitoring
  bool startMonitoring(ThresholdConfig cfg); // DeviceActivityCenter.start
  bool stopMonitoring(String configId);

  // Read & clear low-granularity events (from App Group)
  List<MonitorEvent?> readAndClearMonitorEvents();

  // Convenience
  String appGroupId(); 
}
