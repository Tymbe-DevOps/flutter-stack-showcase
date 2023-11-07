import 'package:corp_devices/common/env/env_config.dart';
import 'package:corp_devices/common/router/routes.dart';
import 'package:corp_devices/io/model/qr_scanner_type.dart';
import 'package:corp_devices/io/repository/repository_providers.dart';
import 'package:corp_devices/ui/base/error_screen.dart';
import 'package:corp_devices/ui/feature/board/page_app_board.dart';
import 'package:corp_devices/ui/feature/scanner/page_scanner.dart';
import 'package:corp_devices/ui/feature/splash/page_splash_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Caches and Exposes a [GoRouter]
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoute.splash.path,
    debugLogDiagnostics: EnvConfig.isTestEnvironment,
    routes: _routes,
    errorBuilder: (context, _) => ErrorScreen(onRetry: () {}),
    redirect: (context, state) async {
      final isAlreadyLoggedIn = ref.read(authRepoProvider).isLoggedIn();
      final isSplashScreen = state.uri.toString() == AppRoute.splash.path;
      final isLoggingIn = state.isLoggingIn();

      if (isSplashScreen) {
        return isAlreadyLoggedIn ? AppRoute.dashboard.path : AppRoute.login.path;
      }

      if (isLoggingIn) {
        return isAlreadyLoggedIn ? AppRoute.dashboard.path : null;
      }

      // Hide native splash
      FlutterNativeSplash.remove();

      return isAlreadyLoggedIn ? null : AppRoute.splash.path;
    },
  );
});

/// All available routes
List<RouteBase> get _routes => [
      GoRoute(
        name: AppRoute.splash.routeName,
        path: AppRoute.splash.path,
        builder: (context, _) => const SplashScreen(),
      ),
      GoRoute(
        name: AppRoute.dashboard.routeName,
        path: AppRoute.dashboard.path,
        builder: (context, _) => const AppBoardPage(),
      ),
      GoRoute(
        name: AppRoute.scanner.routeName,
        path: AppRoute.scanner.path,
        builder: (context, state) {
          return QRScannerPage(qrScannerType: QrScannerType.client(context));
        },
      ),
    ];

extension GoRouterStateExt on GoRouterState {
  bool isLoggingIn() {
    return uri.toString() == AppRoute.login.path || uri.toString() == AppRoute.register.path;
  }
}
