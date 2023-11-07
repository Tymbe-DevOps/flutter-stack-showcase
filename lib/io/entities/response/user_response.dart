part of 'response.dart';

@freezed
class UserResponse with _$UserResponse {
  const factory UserResponse(
    int id,
    String name,
    @JsonKey(name: "full_name") String fullName,
    String nickname,
  ) = _UserResponse;

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}

/// Fixme: This will be deleted once API will be fixed
@freezed
class DeviceUserResponse with _$DeviceUserResponse {
  const factory DeviceUserResponse(
    int id,
    String name,
    String fullName,
    String nickname,
  ) = _DeviceUserResponse;

  factory DeviceUserResponse.fromJson(Map<String, dynamic> json) =>
      _$DeviceUserResponseFromJson(json);
}
