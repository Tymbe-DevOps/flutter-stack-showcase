import 'package:corp_devices/common/error/exceptions.dart';
import 'package:corp_devices/io/services/api/network_info_checker.dart';
import 'package:dio/dio.dart';

/// Intercepts the internet connection failures
class NoInternetInterceptor extends Interceptor {
  final NetworkInfo networkInfo;

  NoInternetInterceptor({required this.networkInfo});

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (await networkInfo.isConnected) {
      handler.next(options);
    } else {
      handler.reject(
        DioError(
          error: NoInternetException(),
          requestOptions: options,
        ),
      );
    }
  }
}
