import 'dart:io';

import 'package:corp_devices/common/constants/routes.dart';
import 'package:corp_devices/common/extensions/context.dart';
import 'package:corp_devices/common/theme/colors.dart';
import 'package:corp_devices/common/theme/padding.dart';
import 'package:corp_devices/io/enums/qr_type.dart';
import 'package:corp_devices/io/enums/scanner_state.dart';
import 'package:corp_devices/io/model/models.dart';
import 'package:corp_devices/io/model/qr_scanner_type.dart';
import 'package:corp_devices/ui/base/components/adaptive_back_arrow.dart';
import 'package:corp_devices/ui/base/components/adaptive_center_progress_indicator.dart';
import 'package:corp_devices/ui/base/components/toast/animated_corp_toast.dart';
import 'package:corp_devices/ui/base/components/toast/toast_notifier.dart';
import 'package:corp_devices/ui/base/qr_scanner_overlay.dart';
import 'package:corp_devices/ui/feature/scanner/notifier_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loggy/loggy.dart';
import 'package:scan/scan.dart';

/// Scanner page serves for more use-cases
///
/// Scans for login QR codes in Corplifting or scans QR code from device when
/// client app wants to borrow the device
class QRScannerPage extends ConsumerWidget {
  final QrScannerType qrScannerType;

  const QRScannerPage({
    required this.qrScannerType,
    Key? key,
  }) : super(key: key);

  static String routeName() => AppRouteNames.scanner;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      scannerProvider,
      ((QRScannerState? previousState, QRScannerState state) => _listenScannerChanges(
            context,
            ref,
            previousState,
            state,
          )),
    );

    return Scaffold(
      appBar: AppBar(
        leading: const AdaptiveBackArrow(),
        title: Text(context.translate().scan.bar.title),
      ),
      body: Stack(
        children: [
          _BackgroundScannerBody(qrScannerType: qrScannerType),
          _ForegroundScannerBody(qrScannerType: qrScannerType),
        ],
      ),
    );
  }

  /// Listen changes in
  void _listenScannerChanges(
    BuildContext context,
    WidgetRef ref,
    QRScannerState? previousState,
    QRScannerState state,
  ) {
    if (state.state == ScannerState.waitedForScanResultBanner) {
      if (previousState?.state == ScannerState.scanSuccess) {
        final scannerNotifier = ref.read(scannerProvider.notifier);
        context.replaceNamed(
          scannerNotifier.routeFromAppType,
          extra: state.deviceModel,
        );
      } else {
        context.pop();
      }
    }
    if (state.state == ScannerState.scanSuccess) {
      ref.read(toastStateProvider.notifier).updateDescription(_scannerMessage(context));
    }

    if (state.state == ScannerState.scanFailed) {
      ref.read(toastStateProvider.notifier).showError();
    }
  }

  /// Return description based on scanner type
  String _scannerMessage(BuildContext context) {
    if (qrScannerType.key == QrType.device) {
      return context.translate().scan.success.description;
    } else {
      return context.translate().scan.login.success;
    }
  }
}

/// Background of scanner
class _BackgroundScannerBody extends ConsumerStatefulWidget {
  final QrScannerType qrScannerType;
  const _BackgroundScannerBody({required this.qrScannerType, Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __BackgroundScannerBodyState();
}

class __BackgroundScannerBodyState extends ConsumerState<_BackgroundScannerBody> {
  late final ScanController scanController;

  @override
  Widget build(BuildContext context) {
    return ScanView(
      controller: scanController,
      scanAreaScale: 1.0,
      scanLineColor: Colors.transparent,
      onCapture: (String barcode) {
        logDebug('Barcode found! $barcode');

        if (widget.qrScannerType.key == QrType.device) {
          ref.read(scannerProvider.notifier).saveDeviceId(barcode);
        } else {
          ref.read(scannerProvider.notifier).saveTokenFromBarcode(barcode);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    scanController = ScanController();
  }

  @override
  void dispose() {
    scanController.pause();
    super.dispose();
  }
}

/// Foreground of scanner
class _ForegroundScannerBody extends ConsumerWidget {
  final QrScannerType qrScannerType;

  const _ForegroundScannerBody({
    required this.qrScannerType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scannerState = ref.watch(scannerProvider).qrType == qrScannerType.key
        ? ref.watch(scannerProvider).state
        : ScannerState.loading;

    return Stack(
      children: [
        Container(
          decoration: const ShapeDecoration(
            shape: QrScannerOverlayShape(
              cutOutBottomOffset: 70,
              borderColor: AppColors.scannerRoundedOverlay,
              borderRadius: 20,
              borderLength: 30,
              borderWidth: 10,
            ),
          ),
          child: AnimatedOpacity(
            opacity: scannerState == ScannerState.loading ? 1 : 0,
            duration: const Duration(milliseconds: 200),
            child: Center(
              child: Transform.scale(
                scale: Platform.isAndroid ? 1 : 1.5,
                child: const AdaptiveCenterProgressIndicator(),
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.5,
          left: spacingL,
          right: spacingL,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: spacingXXL),
              Text(
                qrScannerType.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: spacingM),
              Text(
                qrScannerType.description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white, height: 1.8),
              ),
            ],
          ),
        ),
        const AnimatedToastSlide(),
      ],
    );
  }
}
