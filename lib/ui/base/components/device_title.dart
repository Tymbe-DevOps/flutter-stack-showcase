import 'package:corp_devices/common/theme/padding.dart';
import 'package:corp_devices/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

/// Device title component
class DeviceTitle extends StatelessWidget {
  final String model;
  final bool maxWidth;

  const DeviceTitle({
    required this.model,
    this.maxWidth = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxWidth ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width * 0.6,
      child: Padding(
        padding: const EdgeInsets.only(top: spacingL, bottom: spacingS),
        child: Text(
          model,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                fontFamily: FontFamily.ginto,
              ),
        ),
      ),
    );
  }
}
