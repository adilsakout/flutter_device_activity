import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_device_activity/screentime_repository.dart';
import 'package:flutter_device_activity/screentime_api.pigeon.dart';

void main() {
  test('sanitize produces minimal payload', () {
    final repo = ScreentimeRepository();
    final event = MonitorEvent()
      ..configId = 'cfg'
      ..type = 'limit_reached'
      ..occurredAtEpochSec = 123;
    final payload = repo.sanitize(event);
    expect(payload, {
      'configId': 'cfg',
      'type': 'limit_reached',
      'occurredAtEpochSec': 123,
    });
  });
}
