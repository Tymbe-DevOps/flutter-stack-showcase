import 'package:corp_devices/io/model/models.dart';
import 'package:corp_devices/io/repository/device_repository.dart';
import 'package:corp_devices/io/repository/repository_providers.dart';
import 'package:corp_devices/io/services/local/device_info_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// [ServiceAppNotifier] StateNotifier provider
final serviceDeviceStateNotifier = StateNotifierProvider.autoDispose<ServiceAppNotifier, ServiceState>((ref) {
  final deviceInfo = ref.read(deviceInfoProvider);
  final deviceRepository = ref.read(deviceRepoProvider);
  return ServiceAppNotifier(
    deviceInfoProvider: deviceInfo,
    deviceRepository: deviceRepository,
  )..fetchDeviceInfo();
});

/// Provides state with info about device
class ServiceAppNotifier extends StateNotifier<ServiceState> {
  final DeviceRepository _deviceRepository;
  final DeviceInfoProvider _deviceInfoProvider;

  ServiceAppNotifier({
    required DeviceInfoProvider deviceInfoProvider,
    required DeviceRepository deviceRepository,
  })  : _deviceInfoProvider = deviceInfoProvider,
        _deviceRepository = deviceRepository,
        super(ServiceState.initial());

  /// Fetching information about [DeviceModel]
  Future<void> fetchDeviceInfo() async {
    final deviceInfo = await _deviceInfoProvider.getDeviceInfo();
    final deviceDetailOrNull = await _deviceRepository.deviceDetail(deviceInfo.uuid);
  }
}
