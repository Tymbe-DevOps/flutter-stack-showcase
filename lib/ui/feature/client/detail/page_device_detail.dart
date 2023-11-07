import 'package:corp_devices/common/constants/constants.dart';
import 'package:corp_devices/common/extensions/extensions.dart';
import 'package:corp_devices/common/theme/padding.dart';
import 'package:corp_devices/io/enums/device_type.dart';
import 'package:corp_devices/io/model/models.dart';
import 'package:corp_devices/ui/base/components/adaptive_back_arrow.dart';
import 'package:corp_devices/ui/base/components/device_title.dart';
import 'package:corp_devices/ui/base/components/gradient_button_overlay.dart';
import 'package:corp_devices/ui/base/components/primary_button.dart';
import 'package:corp_devices/ui/base/components/two_line_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Client device detail
class DeviceDetailPage extends StatelessWidget {
  final DeviceDataModel deviceDataModel;

  const DeviceDetailPage({
    required this.deviceDataModel,
    Key? key,
  }) : super(key: key);

  static String get routeName => AppRoutes.clientDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AdaptiveBackArrow(),
        title: Text(context.translate().device.detail.title),
      ),
      body: _DeviceDetailBody(device: deviceDataModel),
    );
  }
}

/// [DeviceDetailPage] body
class _DeviceDetailBody extends ConsumerWidget {
  final DeviceDataModel device;
  const _DeviceDetailBody({required this.device, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: spacingM),
            child: Scrollbar(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DeviceTitle(model: device.name),
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
        if (_canShowReturnBorrowButton) ...[
          GradientButtonOverlay(color: Theme.of(context).colorScheme.background),
          Positioned(
            left: context.isTablet() ? MediaQuery.of(context).size.width / 4 : 0,
            bottom: spacingL + spacingM,
            child: Hero(
              tag: HeroTags.bottomButtonTag,
              child: PrimaryButton(
                device.takenByMe
                    ? context.translate().device.detail.button.returnDevice
                    : context.translate().device.detail.button.borrow,
                () async {},
                variant: ThemeButtonVariant.dark,
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// Return can be shown only for devices the user who borrowed it
  /// Borrow can be shown only for devices that are available
  bool get _canShowReturnBorrowButton => (device.taken && device.takenByMe) || !device.taken;
}
