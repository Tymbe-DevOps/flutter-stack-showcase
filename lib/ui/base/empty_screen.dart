import 'package:corp_devices/common/theme/colors.dart';
import 'package:corp_devices/common/theme/padding.dart';
import 'package:flutter/material.dart';

/// Screen empty
///
/// Usually when status is [Status.failure]
class EmptyScreen extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;
  final EdgeInsets padding;

  const EmptyScreen({
    required this.title,
    required this.description,
    required this.imagePath,
    this.padding = EdgeInsets.zero,
    Key? key,
  }) : super(key: key);

  @override
  State<EmptyScreen> createState() => _EmptyScreenState();
}

class _EmptyScreenState extends State<EmptyScreen> {
  double opacity = .0;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: opacity,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: spacingL) + widget.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              heightFactor: 0.8,
              child: Image.asset(widget.imagePath),
            ),
            Text(
              widget.title,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    foreground: Paint()
                      ..strokeWidth = 1
                      ..style = PaintingStyle.stroke,
                  ),
            ),
            Text(
              widget.description,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(color: AppColors.black),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() => opacity = 1.0);
    });
  }
}
