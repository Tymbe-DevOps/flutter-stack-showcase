import 'dart:io';

import 'package:corp_devices/common/constants/constants.dart';
import 'package:corp_devices/common/extensions/extensions.dart';
import 'package:corp_devices/common/theme/padding.dart';
import 'package:corp_devices/gen/assets.gen.dart';
import 'package:corp_devices/io/enums/enums.dart';
import 'package:corp_devices/ui/base/components/gradient_button_overlay.dart';
import 'package:corp_devices/ui/base/components/primary_button.dart';
import 'package:corp_devices/ui/base/components/toast/toast_notifier.dart';
import 'package:corp_devices/ui/feature/client/detail/notifier_device_detail.dart';
import 'package:corp_devices/ui/feature/client/detail/state_device_detail.dart';
import 'package:corp_devices/ui/feature/client/list/client_home.dart';
import 'package:corp_devices/ui/feature/scanner/page_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Entry point for Client part of the app
class ClientHomePage extends ConsumerWidget {
  const ClientHomePage({Key? key}) : super(key: key);

  static String get routeName => AppRoutes.clientHome;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clientHomeNotifierProvider);

    ref.listen<DeviceDetailState>(
      deviceDetailNotifier,
      ((_, state) {
        state.result.maybeMap(
          success: (device) {
            ref.read(toastStateProvider.notifier).updateDescription(
                  _descriptionForCurrentAction(
                    state.action,
                    device.getOrElse(() => ""),
                    context,
                  ),
                );
            ref.read(clientHomeNotifierProvider.notifier).refreshTabs();
          },
          error: ((value) {
            ref.read(toastStateProvider.notifier).showError();
          }),
          orElse: () {},
        );
      }),
    );

    return Stack(
      children: [
        Platform.isAndroid
            ? AndroidClientTabBarBody(
                result: state.status,
                children: state.clientListView.map((e) => ClientListView(deviceListView: e)).toList(),
                onRetry: () => _onRetry(ref),
              )
            : IosSegmentedControlClientTabBarBody(
                result: state.status,
                children: state.clientListView.map((e) => Expanded(child: ClientListView(deviceListView: e))).toList(),
                onRetry: () => _onRetry(ref),
              ),

        // Button is shown on for first tab
        if (state.currentTab == ClientTab.all && state.status.isSuccess) ...[
          GradientButtonOverlay(color: Theme.of(context).colorScheme.background),
          const _ScanButton(),
        ],
      ],
    );
  }

  void _onRetry(WidgetRef ref) => ref.invalidate(clientHomeNotifierProvider);

  /// Shows description text for success [CorpToast] toast used in
  /// [IosClientSegmentControlBody] and [AndroidClientTabBarBody]
  String _descriptionForCurrentAction(
    DeviceAction action,
    String? deviceName,
    BuildContext context,
  ) {
    if (action == DeviceAction.borrow) {
      return context.translate().device.borrow.success(device: deviceName ?? "");
    } else {
      return context.translate().device.returnDevice.success(device: deviceName ?? "");
    }
  }
}

/// Shows button with scanner option to open [QRScannerPage]
class _ScanButton extends ConsumerWidget {
  const _ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      left: context.isTablet() ? MediaQuery.of(context).size.width / 4 : 0,
      bottom: spacingL + (context.hasTopNotch() ? spacingM : 0),
      child: Hero(
        tag: HeroTags.bottomButtonTag,
        child: PrimaryButton(
          context.translate().devices.button.scan,
          () => context.pushNamed(
            QRScannerPage.routeName(),
            pathParameters: {AppRouterParam.qrParam: QrType.device.name},
          ),
          iconPath: Assets.icons.qr.path,
          variant: ThemeButtonVariant.dark,
        ),
      ),
    );
  }
}
