import 'package:corp_devices/common/extensions/extensions.dart';
import 'package:corp_devices/io/entities/response/response.dart';
import 'package:corp_devices/io/enums/device_brand.dart';
import 'package:corp_devices/io/enums/device_state.dart';
import 'package:corp_devices/io/enums/device_type.dart';
import 'package:corp_devices/io/model/models.dart';

extension DeviceResponseListExt on List<DeviceResponse> {
  /// Returns mapped entity models from [DeviceResponse] to [DeviceModel]
  List<DeviceModel> toModelList([DeviceState? deviceState]) {
    return map((e) => e.toModel(deviceState)).toList()..add(const EmptyDeviceModel());
  }
}

extension DeviceResponseExt on DeviceResponse {
  /// Returns mapped entity model from [DeviceResponse] to [DeviceModel]
  DeviceModel toModel([DeviceState? deviceState]) {
    return DeviceDataModel(
      brand: DeviceBrand.parseFromText(brand),
      name: name ?? "-",
      serial: serial ?? "-",
      location: location ?? "-",
      system: systemVersion ?? "-",
      inventoryNumber: inventoryNumber ?? "-",
      updatedAt: updatedAt.formatToTime(DateFormatters.humanDateTimeReadableFormat),
      registredAt: createdAt.formatToTime(),
      deviceType: DeviceType.phone,
      borrowedBy: currentUser != null ? "${currentUser?.fullName ?? ""} (${currentUser?.nickname ?? ""})" : "-",
      takenByMe: false,
      deviceState: deviceState ?? (taken ? DeviceState.booked : DeviceState.available),
      taken: taken,
      color: additionalProps?.color ?? "-",
    );
  }
}
