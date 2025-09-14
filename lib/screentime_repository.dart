import 'screentime_api.pigeon.dart';

/// Repository responsible for uploading sanitized Screen Time events.
class ScreentimeRepository {
  /// Converts a [MonitorEvent] into a sanitized payload ready for backend upload.
  Map<String, dynamic> sanitize(MonitorEvent event) {
    return {
      'configId': event.configId,
      'type': event.type,
      'occurredAtEpochSec': event.occurredAtEpochSec,
    };
  }

  /// Placeholder upload method. Replace with real networking logic.
  Future<void> uploadEvents(List<MonitorEvent> events) async {
    for (final event in events) {
      final payload = sanitize(event);
      // TODO: POST [payload] to your backend.
      // ignore: avoid_print
      print('Uploading event: ' + payload.toString());
    }
  }
}
