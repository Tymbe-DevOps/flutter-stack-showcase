import 'package:corp_devices/common/constants/constants.dart';
import 'package:corp_devices/io/entities/response/response.dart';
import 'package:corp_devices/io/services/api/http/api_routes.dart';
import 'package:corp_devices/io/services/api/http/http_service.dart';
import 'package:corp_devices/io/services/local/storage/storage_service.dart';
import 'package:loggy/loggy.dart';

abstract class UserRepository {
  Future<void> fetchMe();
  String get myNickname;
}

class UserRepositoryImpl extends UserRepository {
  final HttpService _httpService;
  final StorageService _storageService;

  UserRepositoryImpl(
    HttpService httpService,
    StorageService storageService,
  )   : _httpService = httpService,
        _storageService = storageService;

  @override
  Future<void> fetchMe() async {
    try {
      final response = await _httpService.get(ApiRoutes.me);
      final user = UserResponse.fromJson(response);
      await Future.wait(
        [
          _storageService.set(HiveConstants.nickname, user.nickname),
          _storageService.set(HiveConstants.fullName, user.fullName),
        ],
      );
    } catch (e) {
      logError("Error while saving my user's data. Error: $e");
    }
  }

  @override
  String get myNickname => _storageService.get<String>(HiveConstants.nickname);
}
