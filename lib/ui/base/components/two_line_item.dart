import 'package:corp_devices/common/theme/colors.dart';
import 'package:corp_devices/common/theme/padding.dart';
import 'package:flutter/material.dart';

/// Widget that shows headline with text below each other
class TwoLineItem extends StatelessWidget {
  final String headline;
  final String text;

  const TwoLineItem({
    required this.headline,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headline.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: AppColors.gray2, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 6),
            Text(
              text,
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.gray4, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
