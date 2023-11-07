import 'package:corp_devices/common/constants/routes.dart';
import 'package:corp_devices/common/error/exceptions.dart';
import 'package:corp_devices/common/extensions/extensions.dart';
import 'package:corp_devices/io/enums/enums.dart';
import 'package:corp_devices/io/model/models.dart';
import 'package:corp_devices/io/repository/device_repository.dart';
import 'package:corp_devices/io/repository/repository_providers.dart';
import 'package:corp_devices/io/repository/login_repository.dart';
import 'package:corp_devices/io/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loggy/loggy.dart';

/// Scanner provider
final scannerProvider =
    StateNotifierProvider<ScannerNotifier, QRScannerState>((ref) {
  final LoginRepository loginRepo = ref.read(loginRepoProvider);
  final DeviceRepository deviceRepo = ref.read(deviceRepoProvider);
  final UserRepository userRepo = ref.read(userRepoProvider);
  return ScannerNotifier(loginRepo, deviceRepo, userRepo);
});

/// Scanner notifier
class ScannerNotifier extends StateNotifier<QRScannerState> {
  final LoginRepository _loginRepository;
  final DeviceRepository _deviceRepository;
  final UserRepository _userRepository;

  ScannerNotifier(
    LoginRepository loginRepository,
    DeviceRepository deviceRepository,
    UserRepository userRepository,
  )   : _loginRepository = loginRepository,
        _deviceRepository = deviceRepository,
        _userRepository = userRepository,
        super(QRScannerState.initial());

  /// Parsing code from barcode
  /// Barcode's format is: "email:token"
  List<String> _parseLoginCode(String barcode) => barcode.split(":");

  /// Getting device detail from API
  Future<void> saveDeviceId(String barcode) async {
    state = state.copyWith(
      qrType: QrType.device,
      state: ScannerState.loading,
    );

    final deviceResult = await _deviceRepository.deviceDetail(barcode);

    deviceResult.maybeWhen(
      success: (device) {
        state = state.copyWith(
          state: ScannerState.scanSuccess,
          deviceModel: device.toModel(),
        );
        _resultScanWaitForBanner();
      },
      error: (_) {
        state = state.copyWith(state: ScannerState.scanFailed);
        _resultScanWaitForBanner();
      },
      orElse: () {},
    );
  }

  /// Returns route name from type
  String get routeFromAppType {
    if (state.qrType == QrType.device) {
      return AppRoutes.clientDetail;
    } else {
      final selectedType = _loginRepository.getAppType();
      return selectedType == AppType.client
          ? AppRoutes.clientDetail
          : AppRoutes.serviceHome;
    }
  }

  /// Saves scanned token<
  Future<void> saveTokenFromBarcode(String barcode) async {
    state = state.copyWith(state: ScannerState.loading);
    final selectedType = _loginRepository.getAppType();

    try {
      if (selectedType == null) {
        throw IllegalArgumentException("User did not select app type first.");
      }

      final codes = _parseLoginCode(barcode);
      final token = codes.last;

      await _loginRepository.saveSession(token, selectedType);
      await _userRepository.fetchMe();
      state = state.copyWith(state: ScannerState.scanSuccess);
      _resultScanWaitForBanner();
    } catch (e) {
      logError("Error while saving token from barcode: $e");
      state = state.copyWith(state: ScannerState.scanFailed);
    }
  }

  /// Waiting for showing and hiding a success / failed banner
  ///
  /// After this function is completed, the banner should be already dismissed
  /// and other app operations are done, eg. navigating to previous screen
  /// or app refetching data
  void _resultScanWaitForBanner() {
    Future.delayed(
      const Duration(milliseconds: 1800),
      () => state = state.copyWith(
        state: ScannerState.waitedForScanResultBanner,
      ),
    );
  }

  @override
  bool updateShouldNotify(QRScannerState old, QRScannerState current) {
    return old != current;
  }
}
