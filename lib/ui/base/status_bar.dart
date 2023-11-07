import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Changes color of system icons in status bar
///
/// Depends on [SystemUiOverlayStyle]
/// icons are black in dark [style]
enum StatusType { dark, light }

/// Status bar configuration with [StatusType.dark] or [StatusType.light] icons
class StatusBar extends StatelessWidget {
  final Widget child;

  final Color statusColor;
  final StatusType statusType;

  const StatusBar({
    required this.child,
    required this.statusType,
    this.statusColor = Colors.transparent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: statusColor,
        statusBarIconBrightness:
            statusType == StatusType.dark ? Brightness.dark : Brightness.light,
        statusBarBrightness:
            statusType == StatusType.dark ? Brightness.light : Brightness.dark,
      ),
      child: child,
    );
  }
}
