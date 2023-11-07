import 'dart:io';

import 'package:corp_devices/common/extensions/extensions.dart';
import 'package:corp_devices/common/theme/colors.dart';
import 'package:corp_devices/common/theme/padding.dart';
import 'package:corp_devices/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Primary filled button with corners
class PrimaryButton extends StatelessWidget {
  final String text;
  final String? iconPath;
  final ThemeButtonVariant variant;
  final VoidCallback onTap;

  final buttonHeight = 63.0;

  const PrimaryButton(
    this.text,
    this.onTap, {
    required this.variant,
    this.iconPath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.isTablet() ? MediaQuery.of(context).size.width / 2 : MediaQuery.of(context).size.width,
      height: buttonHeight,
      padding: const EdgeInsets.symmetric(horizontal: spacingXL),
      child: Material(
        color: variant.background,
        child: AdaptiveButtonOverlay(
          color: variant.background,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: spacingL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: variant.foreground),
                ),
                SvgPicture.asset(
                  iconPath ?? Assets.icons.arrow.path,
                  color: variant.foreground,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Button has many variants which can be customized
enum ThemeButtonVariant {
  dark(background: AppColors.black, foreground: AppColors.white),
  light(background: AppColors.gray1, foreground: AppColors.black);

  const ThemeButtonVariant({
    required this.background,
    required this.foreground,
  });

  final Color background;
  final Color foreground;
}

/// Adaptive button overlay
///
/// For Android ink is shown when button is tapped
/// For iOS Cupertino style is used to respect the platform
class AdaptiveButtonOverlay extends StatelessWidget {
  final Widget child;
  final Color color;
  final VoidCallback? onTap;

  const AdaptiveButtonOverlay({
    required this.child,
    required this.onTap,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            color: color,
            disabledColor: Colors.transparent,
            borderRadius: BorderRadius.zero,
            padding: EdgeInsets.zero,
            onPressed: onTap,
            child: child,
          )
        : InkWell(
            onTap: onTap,
            child: child,
          );
  }
}
