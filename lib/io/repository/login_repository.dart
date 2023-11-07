import 'package:corp_devices/io/model/models.dart';
import 'package:corp_devices/io/services/local/storage/storage_service.dart';
import 'package:corp_devices/common/constants/constants.dart';
import '../enums/app_type.dart';

abstract class LoginRepository {
  bool isSigned();
  bool isAppTypeChosen();
  Future<void> saveSession(String token, AppType type);
  Session getSession();
  Future<void> saveType(AppType type);
  AppType? getAppType();
  String getToken();
}

class LoginRepositoryImpl extends LoginRepository {
  final StorageService _preferences;

  LoginRepositoryImpl(StorageService preferences) : _preferences = preferences;

  @override
  bool isSigned() {
    return _preferences.has(HiveConstants.token);
  }

  @override
  Future<void> saveSession(String token, AppType type) async {
    Future.wait(
      [
        _preferences.set(HiveConstants.token, token),
        _preferences.set(HiveConstants.appType, type.name),
      ],
    );
  }

  @override
  Session getSession() {
    final appType = getAppType();
    final signed = isSigned();
    return Session(signed: signed, type: appType);
  }

  @override
  String getToken() {
    return _preferences.get<String?>(HiveConstants.token) ?? "";
  }

  @override
  Future<void> saveType(AppType type) async {
    await _preferences.set(HiveConstants.appType, type.name);
  }

  @override
  bool isAppTypeChosen() {
    return _preferences.has(HiveConstants.appType);
  }

  @override
  AppType? getAppType() {
    final type = _preferences.get(HiveConstants.appType);
    return AppType.getByName(type);
  }
}
