import 'package:flutter/widgets.dart';

import 'package:corp_devices/io/enums/device_state.dart';
import 'package:corp_devices/io/model/models.dart';

/// Holds category and it's devices [DeviceModel] in array
@immutable
class DeviceListView {
  final DeviceState deviceState;
  final List<DeviceModel> devices;

  const DeviceListView(this.deviceState, this.devices);

  bool get takenByMe => deviceState == DeviceState.bookedByMe;

  /// Returns if there can be shown [EmptyScreen] widget inside SliverList
  bool canShowEmptyScreen(DeviceModel deviceModel) =>
      devices.length == 1 &&
      deviceModel is EmptyDeviceModel &&
      deviceState == DeviceState.bookedByMe;

  @override
  String toString() =>
      'DeviceListView(deviceState: $deviceState, devices: $devices)';
}
