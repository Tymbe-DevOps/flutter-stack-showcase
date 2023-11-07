part of './models.dart';

/// Representing state of toast
enum CurrentToastState {
  success,
  error,
  none;
}

@freezed
class ToastState with _$ToastState {
  const factory ToastState({
    required CurrentToastState toastState,
    required String description,
  }) = _ToastState;

  factory ToastState.initial() => const ToastState(
        toastState: CurrentToastState.none,
        description: "",
      );
}
