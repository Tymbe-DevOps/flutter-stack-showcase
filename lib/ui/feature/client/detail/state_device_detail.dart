import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:corp_devices/common/result/result.dart';

enum DeviceAction {
  none,
  borrow,
  returnDevice;
}

@immutable
class DeviceDetailState {
  final Result<String> result;
  final DeviceAction action;

  const DeviceDetailState(this.result, this.action);

  factory DeviceDetailState.initial() => DeviceDetailState(
        Result.loading(),
        DeviceAction.none,
      );

  DeviceDetailState copyWith({
    Result<String>? result,
    DeviceAction? action,
  }) {
    return DeviceDetailState(
      result ?? this.result,
      action ?? this.action,
    );
  }
}
