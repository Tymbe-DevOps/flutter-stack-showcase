part of './models.dart';

@freezed
class DeviceModel with _$DeviceModel {
  /// Representing data model of [DeviceModel]
  const factory DeviceModel.data({
    required DeviceBrand brand,
    required String name,
    required String serial,
    required String location,
    required String system,
    required bool taken,
    required String inventoryNumber,
    required String registredAt,
    required String updatedAt,
    required String color,
    required String borrowedBy,
    required bool takenByMe,
    required DeviceType deviceType,
    required DeviceState deviceState,
  }) = DeviceDataModel;

  /// Used as empty item to show spacing
  const factory DeviceModel.empty() = EmptyDeviceModel;

  /// No devices
  const factory DeviceModel.noDevices() = NoDevicesModel;

  factory DeviceModel.mock(DeviceState deviceState) => DeviceModel.data(
        brand: DeviceBrand.apple,
        name: "iPhone 13 Pro 256GB",
        serial: "123456789",
        color: "Red",
        updatedAt: "22.6.2022",
        taken: false,
        takenByMe: false,
        registredAt: "19.6.2022",
        inventoryNumber: "123456789",
        system: "iOS 15.6",
        location: "River",
        deviceState: deviceState,
        borrowedBy: "-",
        deviceType: DeviceType.phone,
      );

  static List<DeviceModel> generateFakeList(
    DeviceState deviceState, [
    int generatedLength = 10,
  ]) {
    return List<DeviceModel>.generate(
          generatedLength,
          (index) => DeviceModel.mock(deviceState),
        ) +
        [const DeviceModel.empty()];
  }
}

extension DeviceDataModelExt on DeviceDataModel {
  String get searchableString {
    return "$name $inventoryNumber $system $serial ${brand.brand} ${brand.system?.orEmpty()}";
  }
}
