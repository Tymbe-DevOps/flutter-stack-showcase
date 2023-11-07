import 'package:corp_devices/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Adaptive circular progress indicator
class AdaptiveCenterProgressIndicator extends StatelessWidget {
  const AdaptiveCenterProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(Assets.json.loading),
    );
  }
}
