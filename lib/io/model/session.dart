part of './models.dart';

@freezed
class Session with _$Session {
  const factory Session({
    required bool signed,
    AppType? type,
  }) = _Session;
}
