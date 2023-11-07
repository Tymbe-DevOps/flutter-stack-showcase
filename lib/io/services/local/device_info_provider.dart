import 'dart:convert';
import 'dart:io';

import 'package:corp_devices/common/extensions/extensions.dart';
import 'package:corp_devices/gen/assets.gen.dart';
import 'package:corp_devices/io/services/api/interceptors/user_agent_interceptor.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deviceInfoProvider = Provider<DeviceInfoProvider>(
  (ref) {
    final device = DeviceInfoProvider();
    return device;
  },
);

class DeviceInfoProvider {
  Future<PlatformDeviceInfo> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidDevice = await deviceInfo.androidInfo;
      return PlatformDeviceInfo(
        deviceBrand: androidDevice.brand.capitalize(),
        deviceModel: androidDevice.model.replaceWithDash(),
        uuid: androidDevice.androidId,
        osVersion: androidDevice.version.release,
        model: androidDevice.model,
      );
    } else {
      final iosDevice = await deviceInfo.iosInfo;
      final modelName = await _getDeviceModelNameFromCode(iosDevice);

      return PlatformDeviceInfo(
        deviceBrand: 'Apple',
        deviceModel: modelName,
        uuid: iosDevice.identifierForVendor,
        osVersion: iosDevice.systemVersion,
        model: modelName,
      );
    }
  }

  /// UIDevice returns only code model (iPhone14,2) not that it's iPhone 13 Pro
  ///
  /// This info is stored in json in assets to mapped
  /// ! Keep in mind that in future device releases this file must be updated
  Future<String> _getDeviceModelNameFromCode(IosDeviceInfo iosDevice) async {
    final allAppleModelCodes = await json.decode(
      await rootBundle.loadString(Assets.json.appleDevicesCodes),
    );

    final deviceModelCode = iosDevice.utsname.machine;
    final modelName = allAppleModelCodes[deviceModelCode] ?? "Unknown";
    return modelName;
  }
}
