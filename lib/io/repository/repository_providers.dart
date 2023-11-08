import 'package:corp_devices/io/repository/device_repository.dart';
import 'package:corp_devices/io/repository/login_repository.dart';
import 'package:corp_devices/io/repository/user_repository.dart';
import 'package:corp_devices/io/services/api/http/http_service_providers.dart';
import 'package:corp_devices/io/services/local/storage/hive_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// [LoginRepository] provider
final loginRepoProvider = Provider((ref) {
  final preferences = ref.read(storageServiceProvider);
  return LoginRepositoryImpl(preferences);
});

/// [DeviceRepository] provider
final deviceRepoProvider = Provider((ref) {
  final httpService = ref.read(httpServiceProvider(false));
  return DeviceRepositoryImpl(httpService);
});

/// [UserRepository] provider
final userRepoProvider = Provider((ref) {
  final httpService = ref.read(httpServiceProvider(false));
  final preferences = ref.read(storageServiceProvider);
  return UserRepositoryImpl(httpService, preferences);
});
