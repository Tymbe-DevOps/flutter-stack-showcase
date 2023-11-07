import 'package:corp_devices/common/result/result.dart';
import 'package:corp_devices/io/entities/response/response.dart';
import 'package:corp_devices/io/services/api/http/api_routes.dart';
import 'package:corp_devices/io/services/api/http/http_service.dart';

abstract class DeviceRepository {
  Future<Result<List<DeviceResponse>>> fetchAllDevices();
  Future<Result<DeviceResponse>> deviceDetail(String serial);

  borrowDevice(String serial) {}

  releaseDevice(String serial) {}
}

class DeviceRepositoryImpl extends DeviceRepository {
  final HttpService _httpService;

  DeviceRepositoryImpl(HttpService httpService) : _httpService = httpService;

  @override
  Future<Result<List<DeviceResponse>>> fetchAllDevices() {
    return Result.guardFuture(() async {
      final response = await _httpService.get(ApiRoutes.allDevices);
      return (response as List).map<DeviceResponse>((todo) => DeviceResponse.fromJson(todo)).toList();
    });
  }

  @override
  Future<Result<DeviceResponse>> deviceDetail(String serial) {
    return Result.guardFuture(() async {
      final response = await _httpService.get(
        "${ApiRoutes.allDevices}/${serial.toUpperCase()}",
      );
      return DeviceResponse.fromJson(response);
    });
  }
}
