import 'package:corp_devices/io/services/api/interceptors/user_agent_interceptor.dart';
import 'package:corp_devices/io/services/local/device_info_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Device info provider
final serviceAppProvider = FutureProvider<PlatformDeviceInfo>(
  (ref) async {
    final info = await ref.read(deviceInfoProvider).getDeviceInfo();
    return info;
  },
);
