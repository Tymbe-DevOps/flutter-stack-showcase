import 'package:corp_devices/common/constants/constants.dart';
import 'package:corp_devices/common/extensions/extensions.dart';
import 'package:corp_devices/common/theme/colors.dart';
import 'package:corp_devices/common/theme/padding.dart';
import 'package:corp_devices/gen/assets.gen.dart';
import 'package:corp_devices/io/enums/enums.dart';
import 'package:corp_devices/io/model/models.dart';
import 'package:corp_devices/ui/base/components/adaptive_back_arrow.dart';
import 'package:corp_devices/ui/base/components/adaptive_center_progress_indicator.dart';
import 'package:corp_devices/ui/base/components/device_title.dart';
import 'package:corp_devices/ui/base/components/primary_button.dart';
import 'package:corp_devices/ui/base/components/two_line_item.dart';
import 'package:corp_devices/ui/base/error_screen.dart';
import 'package:corp_devices/ui/feature/service/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../base/components/gradient_button_overlay.dart';

/// Service home app
class ServiceHomePage extends StatelessWidget {
  const ServiceHomePage({Key? key}) : super(key: key);

  static String get routeName => AppRoutes.serviceHome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AdaptiveBackArrow(),
        title: Text(context.translate().device.detail.title),
      ),
      body: const SafeArea(
        bottom: false,
        child: _ServiceBody(),
      ),
    );
  }
}

class _ServiceBody extends ConsumerWidget {
  const _ServiceBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(serviceDeviceStateNotifier);

    return state.detailStatus.when(
      error: (_) => ErrorScreen(
        onRetry: () => ref.refresh(serviceDeviceStateNotifier),
      ),
      loading: () => const Center(
        child: AdaptiveCenterProgressIndicator(),
      ),
      success: (DeviceDataModel device) => Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: spacingM),
              child: Scrollbar(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DeviceTitle(
                      model: device.name,
                      maxWidth: false,
                    ),
                    _LastUpdatedDateTitle(lastUpdated: device.updatedAt),
                    TwoLineItem(
                      headline: context.translate().device.detail.brand,
                      text: device.brand.brand,
                    ),
                    TwoLineItem(
                      headline: context.translate().device.detail.deviceType,
                      text: device.deviceType.title(context),
                    ),
                    TwoLineItem(
                      headline: context.translate().device.detail.color,
                      text: device.color,
                    ),
                    TwoLineItem(
                      headline: context.translate().device.detail.osVersion,
                      text: device.system,
                    ),
                    TwoLineItem(
                      headline: context.translate().device.detail.inventoryNumber,
                      text: device.inventoryNumber,
                    ),
                    TwoLineItem(
                      headline: context.translate().device.detail.serialNumber,
                      text: device.serial,
                    ),
                    TwoLineItem(
                      headline: context.translate().device.detail.registred,
                      text: device.registredAt,
                    ),
                    TwoLineItem(
                      headline: context.translate().device.detail.borrowedBy,
                      text: device.borrowedBy,
                    ),
                    const SizedBox(height: 150),
                  ],
                ),
              ),
            ),
          ),
          _QRSerialImage(serialNumber: device.serial),
          GradientButtonOverlay(color: Theme.of(context).colorScheme.background),
          Positioned(
            left: context.isTablet() ? MediaQuery.of(context).size.width / 4 : 0,
            bottom: spacingXL + spacingM,
            child: PrimaryButton(
              context.translate().device.button.update,
              () {
                // TODO: Do something
              },
              iconPath: Assets.icons.refresh.path,
              variant: ThemeButtonVariant.dark,
            ),
          )
        ],
      ),
    );
  }
}

/// Shows last update text with rounded chip
class _LastUpdatedDateTitle extends StatelessWidget {
  final String lastUpdated;

  const _LastUpdatedDateTitle({
    required this.lastUpdated,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(
        horizontal: spacingS,
        vertical: spacingS,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        context.translate().device.detail.lastUpdated(date: lastUpdated),
        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.gray4, fontWeight: FontWeight.w400),
      ),
    );
  }
}

/// Shows in app generated QR from serial number
///
/// This QR code can be scanned by client side of the app
class _QRSerialImage extends StatelessWidget {
  final String serialNumber;

  const _QRSerialImage({
    required this.serialNumber,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: spacingM,
      top: spacingM,
      child: GestureDetector(
        onTap: () => _showQrCodeDetailModal(context),
        child: _QrCodeImage(
          height: context.isTablet() ? 225 : 120,
          serialNumber: serialNumber,
        ),
      ),
    );
  }

  void _showQrCodeDetailModal(BuildContext context) {
    showBarModalBottomSheet(
      context: context,
      builder: (_) {
        return FractionallySizedBox(
          heightFactor: 0.6,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: spacingXL),
              child: _QrCodeImage(
                height: context.isTablet() ? 350 : 300,
                serialNumber: serialNumber,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Wrapper around generating QR code image
class _QrCodeImage extends StatelessWidget {
  final double height;
  final String serialNumber;

  const _QrCodeImage({
    required this.height,
    required this.serialNumber,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QrImage(
      data: serialNumber,
      size: height,
      gapless: false,
      errorStateBuilder: (cxt, err) {
        return Center(
          child: Text(
            context.translate().scan.failed.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
          ),
        );
      },
    );
  }
}
