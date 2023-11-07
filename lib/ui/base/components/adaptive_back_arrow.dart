import 'dart:io';
import 'package:corp_devices/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Shows back arrow corresponding the platform the app lives in
class AdaptiveBackArrow extends StatelessWidget {
  const AdaptiveBackArrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: MaterialLocalizations.of(context).backButtonTooltip,
      child: GestureDetector(
        onTap: () => context.pop(),
        child: Platform.isAndroid
            ? Padding(
                padding: const EdgeInsets.all(15),
                child: Assets.icons.chevronAndroid.svg(),
              )
            : Padding(
                padding: const EdgeInsets.all(10),
                child: Assets.icons.chevronIos.svg(),
              ),
      ),
    );
  }
}
