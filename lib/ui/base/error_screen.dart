import 'package:corp_devices/common/extensions/extensions.dart';
import 'package:corp_devices/common/theme/colors.dart';
import 'package:corp_devices/common/theme/padding.dart';
import 'package:corp_devices/gen/assets.gen.dart';
import 'package:corp_devices/ui/base/components/primary_button.dart';
import 'package:flutter/material.dart';

/// Skeleton for error state
///
/// Usually when status is [Status.failure]
class ErrorScreen extends StatefulWidget {
  /// Retry last operation
  final VoidCallback onRetry;

  const ErrorScreen({
    required this.onRetry,
    Key? key,
  }) : super(key: key);

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  double opacity = .0;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: opacity,
      child: SafeArea(
        bottom: true,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: spacingL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Assets.images.error.image(
                      height: MediaQuery.of(context).size.height * 0.4,
                    ),
                  ),
                  Text(
                    context.translate().error.title,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          foreground: Paint()
                            ..strokeWidth = 1
                            ..style = PaintingStyle.stroke,
                        ),
                  ),
                  Text(
                    context.translate().error.description,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(color: AppColors.black),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: PrimaryButton(
                context.translate().error.tryAgain,
                widget.onRetry,
                variant: ThemeButtonVariant.dark,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        opacity = 1.0;
      });
    });
  }
}
