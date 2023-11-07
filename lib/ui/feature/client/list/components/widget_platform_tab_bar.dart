import 'package:corp_devices/common/result/result.dart';
import 'package:flutter/material.dart';

class AndroidClientTabBarBody extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback onRetry;
  final Result<void> result;

  const AndroidClientTabBarBody({
    super.key,
    required this.children,
    required this.onRetry,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class IosSegmentedControlClientTabBarBody extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback onRetry;
  final Result<void> result;

  const IosSegmentedControlClientTabBarBody({
    super.key,
    required this.children,
    required this.onRetry,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
