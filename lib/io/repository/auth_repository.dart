import 'package:corp_devices/common/constants/preferences.dart';
import 'package:corp_devices/common/result/result.dart';
import 'package:corp_devices/io/services/api/http/api_routes.dart';
import 'package:corp_devices/io/services/api/http/dio_http_service.dart';
import 'package:corp_devices/io/services/api/http/http_service.dart';
import 'package:corp_devices/io/services/local/storage/storage_service.dart';

abstract class AuthRepository {
  Future<Result<void>> logout();
  bool isLoggedIn();
  Future<Result<String>> loginWithEmailPassword(String email, String password);
  Future<Result<String>> registerWithEmailPassword(
    String email,
    String password,
    String username,
  );
}

class ClientAuthRepository extends AuthRepository {
  final HttpService _client;
  final StorageService _storageService;

  ClientAuthRepository(
    DioHttpService httpService,
    StorageService preferences,
  )   : _client = httpService,
        _storageService = preferences;

  @override
  bool isLoggedIn() {
    return _storageService.has(HiveConstants.token);
  }

  @override
  Future<Result<String>> loginWithEmailPassword(
    String email,
    String password,
  ) async {
    return await Result.guardFuture(() async {
      //TODO: Should be class instead of Map (LoginRequestDto)

      final response = await _client.post(ApiRoutes.login, data: {
        "email": email,
        "password": password,
      });

      // final data = LoginResponseDto.fromJson(response);

      // Future.wait([
      //   _storageService.setString(
      //     HiveConstants.token,
      //     data.accessToken,
      //   ),
      //   _storageService.setString(
      //     HiveConstants.refreshToken,
      //     data.refreshToken,
      //   ),
      // ]);

      return "";
    });
  }

  @override
  Future<Result<String>> registerWithEmailPassword(
    String email,
    String password,
    String username,
  ) async {
    return await Result.guardFuture(() async {
      //TODO: Should be class instead of Map (RegisterRequestDto)
      final response = await _client.post(ApiRoutes.register, data: {
        "email": email,
        "password": password,
        "username": username,
      });

      // final data = LoginResponseDto.fromJson(response);

      // Future.wait([
      //   _storageService.setString(
      //     HiveConstants.token,
      //     data.accessToken,
      //   ),
      //   _storageService.setString(
      //     HiveConstants.refreshToken,
      //     data.refreshToken,
      //   ),
      // ]);

      return "";
    });
  }

  @override
  Future<Result<void>> logout() {
    return Result.guardFuture(() async {
      // await _client.post(ApiRoutes.logout);
      // await _storageService.remove(HiveConstants.token);
      // await _storageService.remove(HiveConstants.refreshToken);
    });
  }
}
