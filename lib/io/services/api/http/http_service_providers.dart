import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:corp_devices/common/constants/constants.dart';
import 'package:corp_devices/common/env/env_config.dart';
import 'package:corp_devices/io/services/api/http/dio_http_service.dart';
import 'package:corp_devices/io/services/api/interceptors/interceptors.dart';
import 'package:corp_devices/io/services/local/storage/hive_storage_service.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final logInterceptor = Provider<PrettyDioLogger>(
  (ref) {
    final envConfig = ref.read(envConfigProvider);
    final canPrint = envConfig.isTestEnvironment;

    final logInterceptor = PrettyDioLogger(
      request: canPrint,
      requestBody: canPrint,
      responseBody: canPrint,
      error: canPrint,
      responseHeader: false,
      requestHeader: false,
    );

    return logInterceptor;
  },
);

/// Connection internet checker
final networkInfoProvider = Provider(
  (ref) {
    final networkConnectionChecker = Connectivity();
    return NetworkInfoImpl(networkConnectionChecker);
  },
);

/// Connection internet intercoptor
final noInternetProvider = Provider<NoInternetInterceptor>((ref) {
  final noInternetChecker = ref.read(networkInfoProvider);
  return NoInternetInterceptor(networkInfo: noInternetChecker);
});

/// Device info provider
final userAgentProvider = Provider<UserAgentInterceptor>((ref) {
  final deviceInfo = DeviceInfoPlugin();
  return UserAgentInterceptor(deviceInfo: deviceInfo);
});

/// Token interceptor provider
final tokenInterceptorProvider = Provider((ref) {
  final appPreferences = ref.read(storageServiceProvider);
  return TokenInterceptor(localDataSource: appPreferences);
});

/// Base URL
final baseUrlProvider = Provider<String>((ref) {
  final envConfig = ref.read(envConfigProvider);
  return envConfig.isTestEnvironment ? ApiConstants.baseStageUrl : ApiConstants.baseProdUrl;
});

/// HTTP custom client
final httpServiceProvider = Provider.autoDispose.family<DioHttpService, bool>((
  ref,
  provideHttpCache,
) {
  final storageService = ref.watch(storageServiceProvider);
  final baseUrl = ref.watch(baseUrlProvider);

  final noInternetInterceptor = ref.watch(noInternetProvider);
  final userAgentInterceptor = ref.watch(userAgentProvider);
  final tokenInterceptor = ref.watch(tokenInterceptorProvider);
  final loggingInterceptor = ref.watch(logInterceptor);

  return DioHttpService(
    storageService,
    baseUrl,
    enableCaching: provideHttpCache,
    appInterceptors: [
      noInternetInterceptor,
      userAgentInterceptor,
      tokenInterceptor,
      loggingInterceptor,
    ],
  );
});
