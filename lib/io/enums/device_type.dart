import 'package:corp_devices/common/extensions/extensions.dart';
import 'package:corp_devices/gen/assets.gen.dart';
import 'package:flutter/material.dart';

enum DeviceType {
  /// Phone device
  phone,

  /// Tablet device
  tablet,

  /// Smartwatch
  watches,

  /// Another type which is not currently supported but can be added
  other;
}

/// Return icon path from given [DeviceType]
extension DeviceTypeExt on DeviceType {
  String get iconPath {
    switch (this) {
      case DeviceType.phone:
        return Assets.icons.mobile.path;
      case DeviceType.tablet:
        return Assets.icons.tablet.path;
      case DeviceType.watches:
        return Assets.icons.watches.path;
      default:
        return Assets.icons.laptop.path;
    }
  }

  String title(BuildContext context) {
    switch (this) {
      case DeviceType.phone:
        return context.translate().device.types.device;
      case DeviceType.tablet:
        return context.translate().device.types.tablet;
      case DeviceType.watches:
        return context.translate().device.types.smartwatch;
      default:
        return context.translate().device.types.computer;
    }
  }
}
