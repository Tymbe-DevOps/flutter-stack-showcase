import 'package:corp_devices/io/model/models.dart';
import 'package:corp_devices/ui/base/components/toast/toast_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:corp_devices/ui/base/components/snackbar.dart';

/// Animated widget of [CorpToast]
class AnimatedToastSlide extends ConsumerStatefulWidget {
  const AnimatedToastSlide({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AnimatedToastSlide> createState() => __AnimatedToastSlideState();
}

class __AnimatedToastSlideState extends ConsumerState<AnimatedToastSlide> with SingleTickerProviderStateMixin {
  final Offset _startOffset = const Offset(0, -1);

  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  @override
  Widget build(BuildContext context) {
    final toastState = ref.watch(toastStateProvider);

    ref.listen<ToastState>(
      toastStateProvider,
      (_, state) async {
        if (state.toastState != CurrentToastState.none) {
          _controller.forward();
          await Future.delayed(const Duration(milliseconds: 1500));
          _controller.reverse();
        }
      },
    );

    return SlideTransition(
      position: _offsetAnimation,
      child: CorpToast(
        toastState.toastState == CurrentToastState.error
            ? ToastStyle.error(context)
            : ToastStyle.success(
                toastState.description,
                context,
              ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: _startOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
