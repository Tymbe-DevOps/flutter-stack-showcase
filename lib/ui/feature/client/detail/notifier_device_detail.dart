import 'package:corp_devices/common/result/result.dart';
import 'package:corp_devices/io/model/models.dart';
import 'package:corp_devices/io/repository/device_repository.dart';
import 'package:corp_devices/io/repository/repository_providers.dart';
import 'package:corp_devices/ui/feature/client/detail/device_detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for [DeviceDetailStateNotifier]
final deviceDetailNotifier = StateNotifierProvider.autoDispose<DeviceDetailStateNotifier, DeviceDetailState>(
  (ref) {
    final DeviceRepository deviceRepository = ref.read(deviceRepoProvider);
    return DeviceDetailStateNotifier(deviceRepository: deviceRepository);
  },
);

/// Notifier for releasing and borrowing devices
class DeviceDetailStateNotifier extends StateNotifier<DeviceDetailState> {
  final DeviceRepository _deviceRepository;

  DeviceDetailStateNotifier({
    required DeviceRepository deviceRepository,
  })  : _deviceRepository = deviceRepository,
        super(DeviceDetailState.initial());

  Future<void> borrowDevice(DeviceDataModel device) async {
    state = state.copyWith(
      result: Result.loading(),
      action: DeviceAction.borrow,
    );

    final result = await _deviceRepository.borrowDevice(device.serial);

    result.maybeWhen(
      success: (data) {
        state = state.copyWith(result: Result.success(device.name));
      },
      error: ((error) {
        state = state.copyWith(
          result: Result.error(error),
        );
      }),
      orElse: () {},
    );
  }

  Future<void> returnDevice(DeviceDataModel device) async {
    state = state.copyWith(
      result: Result.loading(),
      action: DeviceAction.returnDevice,
    );

    final result = await _deviceRepository.releaseDevice(device.serial);

    result.maybeWhen(
      success: (data) {
        state = state.copyWith(result: Result.success(device.name));
      },
      error: ((error) {
        state = state.copyWith(result: Result.error(error));
      }),
      orElse: () {},
    );
  }
}
