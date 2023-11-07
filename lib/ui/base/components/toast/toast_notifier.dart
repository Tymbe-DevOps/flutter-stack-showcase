import 'package:corp_devices/io/model/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final toastStateProvider = StateNotifierProvider<ToastStateNotifier, ToastState>((ref) {
  return ToastStateNotifier();
});

class ToastStateNotifier extends StateNotifier<ToastState> {
  ToastStateNotifier() : super(ToastState.initial());

  /// Changing description for [ToastState]
  void updateDescription(String description) {
    state = state.copyWith(
      toastState: CurrentToastState.success,
      description: description,
    );
  }

  /// Show error toast
  ///
  /// description is omitted here
  void showError() {
    state = state.copyWith(toastState: CurrentToastState.error);
  }
}
