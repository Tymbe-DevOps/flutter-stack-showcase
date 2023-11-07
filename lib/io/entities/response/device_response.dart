part of 'response.dart';

@freezed
class DeviceResponse with _$DeviceResponse {
  const factory DeviceResponse(
    String? serial,
    String brand,
    String? name,
    String? location,
    String? sublocation,
    bool taken,
    DeviceUserResponse? currentUser,
    String? systemVersion,
    String? inventoryNumber,
    AdditionalPropsDto? additionalProps,
    String updatedAt,
    String createdAt,
  ) = _DeviceResponse;

  factory DeviceResponse.fromJson(Map<String, dynamic> json) => _$DeviceResponseFromJson(json);
}

@freezed
class AdditionalPropsDto with _$AdditionalPropsDto {
  const factory AdditionalPropsDto(final String? color) = _AdditionalPropsDto;

  factory AdditionalPropsDto.fromJson(Map<String, dynamic> json) => _$AdditionalPropsDtoFromJson(json);
}
