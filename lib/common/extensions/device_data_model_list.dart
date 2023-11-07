import 'package:corp_devices/common/search/fulltext_search_engine.dart';
import 'package:corp_devices/io/entities/response/response.dart';
import 'package:corp_devices/io/model/models.dart';

extension ListDeviceDataModelExt on Iterable<DeviceDataModel> {
  /// Filter by given search query
  List<DeviceModel> filterByQuery(String query) {
    List<DeviceModel> devices = List.empty();

    if (query.isNotEmpty) {
      devices = where(
        (device) => FullTextSearchEngine.search(
          query: query,
          searchableString: device.searchableString,
        ),
      ).toList();
    } else {
      devices = toList();
    }

    devices = devices.cast<DeviceModel>().toList();
    if (devices.isEmpty) devices.add(const NoDevicesModel());
    devices.add(const EmptyDeviceModel());
    return devices;
  }
}

extension ListDeviceResponseExt on Iterable<DeviceResponse> {
  /// Filter by given search query
  List<DeviceResponse> filterTaken({required bool taken}) {
    return where((device) => device.taken == taken).toList();
  }
}
