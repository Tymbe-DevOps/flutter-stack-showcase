part of './models.dart';

/// Scan states for [ScannerNotifier]
@freezed
class QRScannerState with _$QRScannerState {
  const factory QRScannerState({
    required QrType? qrType,
    required ScannerState state,
    required DeviceModel? deviceModel,
  }) = _QRScannerState;

  factory QRScannerState.initial() => const QRScannerState(
        qrType: null,
        deviceModel: null,
        state: ScannerState.none,
      );
}
