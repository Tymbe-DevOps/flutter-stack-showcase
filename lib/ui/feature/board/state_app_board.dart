import 'package:flutter/foundation.dart';

import 'package:corp_devices/io/enums/app_type.dart';

/// Indicates what listener should route
enum RedirectPage {
  none,
  scanner,
  home;
}

@immutable
class DashboardState {
  final RedirectPage redirectPage;
  final AppType? type;

  const DashboardState(this.redirectPage, this.type);
  factory DashboardState.initial() => const DashboardState(
        RedirectPage.none,
        null,
      );

  factory DashboardState.selectedType(AppType type) => DashboardState(
        RedirectPage.scanner,
        type,
      );

  factory DashboardState.skipScanner(AppType type) => DashboardState(
        RedirectPage.home,
        type,
      );

  @override
  String toString() =>
      'DashboardState(redirectPage: $redirectPage, type: $type)';
}
