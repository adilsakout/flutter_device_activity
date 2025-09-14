// GENERATED CODE - DO NOT MODIFY BY HAND
// See pigeons/screentime.dart for input definitions.

import 'dart:async';
import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

class ThresholdConfig {
  ThresholdConfig({this.configId, this.bundleIds, this.secondsLimit, this.schedule});
  String? configId;
  List<String?>? bundleIds;
  int? secondsLimit;
  String? schedule;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['configId'] = configId;
    pigeonMap['bundleIds'] = bundleIds;
    pigeonMap['secondsLimit'] = secondsLimit;
    pigeonMap['schedule'] = schedule;
    return pigeonMap;
  }

  static ThresholdConfig decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return ThresholdConfig(
      configId: pigeonMap['configId'] as String?,
      bundleIds: (pigeonMap['bundleIds'] as List<Object?>?)?.cast<String?>(),
      secondsLimit: pigeonMap['secondsLimit'] as int?,
      schedule: pigeonMap['schedule'] as String?,
    );
  }
}

class MonitorEvent {
  MonitorEvent({this.configId, this.type, this.occurredAtEpochSec});
  String? configId;
  String? type;
  int? occurredAtEpochSec;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['configId'] = configId;
    pigeonMap['type'] = type;
    pigeonMap['occurredAtEpochSec'] = occurredAtEpochSec;
    return pigeonMap;
  }

  static MonitorEvent decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return MonitorEvent(
      configId: pigeonMap['configId'] as String?,
      type: pigeonMap['type'] as String?,
      occurredAtEpochSec: pigeonMap['occurredAtEpochSec'] as int?,
    );
  }
}

class _ScreentimeHostApiCodec extends StandardMessageCodec {
  const _ScreentimeHostApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is ThresholdConfig) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is MonitorEvent) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return ThresholdConfig.decode(readValue(buffer)!);
      case 129:
        return MonitorEvent.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class ScreentimeHostApi {
  /// Constructor for [ScreentimeHostApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  ScreentimeHostApi({BinaryMessenger? binaryMessenger}) : _binaryMessenger = binaryMessenger;

  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _ScreentimeHostApiCodec();

  Future<bool> requestAuthorization() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>('dev.flutter.pigeon.ScreentimeHostApi.requestAuthorization', codec, binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(code: 'channel-error', message: 'Unable to establish connection on channel.', details: null);
    } else if (replyList.length > 1) {
      throw PlatformException(code: replyList[0]! as String, message: replyList[1] as String?, details: replyList[2]);
    } else {
      return (replyList[0] as bool?)!;
    }
  }

  Future<bool> presentFamilyActivityPicker() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>('dev.flutter.pigeon.ScreentimeHostApi.presentFamilyActivityPicker', codec, binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(code: 'channel-error', message: 'Unable to establish connection on channel.', details: null);
    } else if (replyList.length > 1) {
      throw PlatformException(code: replyList[0]! as String, message: replyList[1] as String?, details: replyList[2]);
    } else {
      return (replyList[0] as bool?)!;
    }
  }

  Future<bool> hasSavedSelection() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>('dev.flutter.pigeon.ScreentimeHostApi.hasSavedSelection', codec, binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(code: 'channel-error', message: 'Unable to establish connection on channel.', details: null);
    } else if (replyList.length > 1) {
      throw PlatformException(code: replyList[0]! as String, message: replyList[1] as String?, details: replyList[2]);
    } else {
      return (replyList[0] as bool?)!;
    }
  }

  Future<bool> startMonitoring(ThresholdConfig arg_cfg) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>('dev.flutter.pigeon.ScreentimeHostApi.startMonitoring', codec, binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(<Object?>[arg_cfg]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(code: 'channel-error', message: 'Unable to establish connection on channel.', details: null);
    } else if (replyList.length > 1) {
      throw PlatformException(code: replyList[0]! as String, message: replyList[1] as String?, details: replyList[2]);
    } else {
      return (replyList[0] as bool?)!;
    }
  }

  Future<bool> stopMonitoring(String arg_configId) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>('dev.flutter.pigeon.ScreentimeHostApi.stopMonitoring', codec, binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(<Object?>[arg_configId]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(code: 'channel-error', message: 'Unable to establish connection on channel.', details: null);
    } else if (replyList.length > 1) {
      throw PlatformException(code: replyList[0]! as String, message: replyList[1] as String?, details: replyList[2]);
    } else {
      return (replyList[0] as bool?)!;
    }
  }

  Future<List<MonitorEvent?>> readAndClearMonitorEvents() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>('dev.flutter.pigeon.ScreentimeHostApi.readAndClearMonitorEvents', codec, binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(code: 'channel-error', message: 'Unable to establish connection on channel.', details: null);
    } else if (replyList.length > 1) {
      throw PlatformException(code: replyList[0]! as String, message: replyList[1] as String?, details: replyList[2]);
    } else {
      return (replyList[0] as List<Object?>?)!.cast<MonitorEvent?>();
    }
  }

  Future<String> appGroupId() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>('dev.flutter.pigeon.ScreentimeHostApi.appGroupId', codec, binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(code: 'channel-error', message: 'Unable to establish connection on channel.', details: null);
    } else if (replyList.length > 1) {
      throw PlatformException(code: replyList[0]! as String, message: replyList[1] as String?, details: replyList[2]);
    } else {
      return (replyList[0] as String?)!;
    }
  }
}
