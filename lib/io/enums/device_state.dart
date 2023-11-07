import 'package:corp_devices/common/extensions/extensions.dart';
import 'package:flutter/material.dart';

enum DeviceState {
  /// Booked by someone else, cannot borrow
  booked,

  /// Available to borrow
  available,

  /// Device booked by me, can be return
  bookedByMe
}

extension DeviceStateExt on DeviceState {
  String buttonTitle(BuildContext context) {
    switch (this) {
      case DeviceState.bookedByMe:
        return context.translate().devices.returnDevice;
      default:
        return context.translate().devices.state.available;
    }
  }

  String headerTitle(BuildContext context) {
    switch (this) {
      case DeviceState.bookedByMe:
        return context.translate().device.state.bookedByMe;
      case DeviceState.available:
        return context.translate().device.state.available;
      case DeviceState.booked:
        return context.translate().device.state.booked;
      default:
        return "";
    }
  }
}
