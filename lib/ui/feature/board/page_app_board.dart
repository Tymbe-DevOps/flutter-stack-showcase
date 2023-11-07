import 'package:corp_devices/common/constants/routes.dart';
import 'package:corp_devices/common/extensions/extensions.dart';
import 'package:corp_devices/common/theme/colors.dart';
import 'package:corp_devices/common/theme/padding.dart';
import 'package:corp_devices/gen/assets.gen.dart';
import 'package:corp_devices/io/enums/enums.dart';
import 'package:corp_devices/ui/base/components/primary_button.dart';
import 'package:corp_devices/ui/base/status_bar.dart';
import 'package:corp_devices/ui/feature/board/notifier_app_board.dart';
import 'package:corp_devices/ui/feature/board/state_app_board.dart';
import 'package:corp_devices/ui/feature/client/list/page_client_home.dart';
import 'package:corp_devices/ui/feature/scanner/scanner.dart';
import 'package:corp_devices/ui/feature/service/page_service_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loggy/loggy.dart';

class AppBoardPage extends ConsumerStatefulWidget {
  const AppBoardPage({Key? key}) : super(key: key);

  static String get routeName => AppRoutes.appBoard;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppBoardPageState();
}

class _AppBoardPageState extends ConsumerState<AppBoardPage> {
  late Image handsImage;

  @override
  Widget build(BuildContext context) {
    ref.listen<DashboardState>(
      appBoardProvider,
      (_, state) {
        if (state.redirectPage == RedirectPage.home) {
          context.push(
            state.type == AppType.client ? ClientHomePage.routeName : ServiceHomePage.routeName,
          );
        }
        if (state.redirectPage == RedirectPage.scanner) {
          context.pushNamed(QRScannerPage.routeName());
        }
      },
    );

    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: StatusBar(
          statusType: StatusType.dark,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const _Title(),
                const SizedBox(height: spacingM),
                Assets.images.hands.image(
                  height: MediaQuery.of(context).size.height / 2,
                ),
                PrimaryButton(
                  context.translate().dashboard.borrow,
                  () async => await _selectAppType(AppType.client, ref),
                  variant: ThemeButtonVariant.dark,
                ),
                const SizedBox(height: spacingM),
                PrimaryButton(
                  context.translate().dashboard.service,
                  () async => await _selectAppType(AppType.service, ref),
                  variant: ThemeButtonVariant.light,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  QrType _scannerNavigation(AppType? appType) {
    return appType == AppType.client ? QrType.client : QrType.service;
  }

  Future<void> _selectAppType(AppType appType, WidgetRef ref) async {
    logInfo("Selected type: $appType");
    await ref.read(appBoardProvider.notifier).selectType(appType);

    // await ref
    //     .read(loginRepoProvider)
    //     .saveSession("229f5ec5-a8c5-43af-b5b4-8c437b226365", AppType.client);
  }

  @override
  void initState() {
    super.initState();
    handsImage = Assets.images.hands.image();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(handsImage.image, context);
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 20),
      alignment: Alignment.centerLeft,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: context.translate().dashboard.selectType,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    foreground: Paint()
                      ..strokeWidth = 1.2
                      ..style = PaintingStyle.stroke,
                  ),
            ),
            TextSpan(
              text: context.translate().dashboard.selectUserType,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: AppColors.black,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
