import 'package:flutter/material.dart';

/// Show gradient on bottom bar
///
/// Usually used for floating [PrimaryButton] not to show hard transition between
/// the above button and the background below it
class GradientButtonOverlay extends StatelessWidget {
  final Color color;
  final double bottomPadding;

  const GradientButtonOverlay({
    required this.color,
    this.bottomPadding = 40.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: bottomPadding,
          left: 0,
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [color.withOpacity(0.01), color],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            color: color,
          ),
        ),
      ],
    );
  }
}
