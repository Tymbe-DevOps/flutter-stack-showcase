import 'package:corp_devices/common/env/env.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Env config given in runtime by --dart-define=environment
class EnvConfig {
  final Env env;
  final String apiUrl;

  EnvConfig._({
    required this.env,
    required this.apiUrl,
  });

  bool get isTestEnvironment => env == Env.dev;

  factory EnvConfig.fromEnvVariables() {
    return EnvConfig._(
      env: Env.fromString(const String.fromEnvironment("ENVIRONMENT")),
      apiUrl: const String.fromEnvironment("API_URL"),
    );
  }
}

/// EnvConfig provider
final envConfigProvider = Provider<EnvConfig>((ref) {
  throw UnimplementedError();
});
