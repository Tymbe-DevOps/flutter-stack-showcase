import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Env config
/// Given in runtime by --dart-define=environment=DEV
class EnvConfig {
  final Env env;
  final String apiUrl;

  EnvConfig({
    required this.env,
    required this.apiUrl,
  });

  bool get isTestEnvironment => env == Env.dev;

  factory EnvConfig.fromEnvVariables() {
    return EnvConfig(
      env: Env.fromString(const String.fromEnvironment("ENVIRONMENT")),
      apiUrl: const String.fromEnvironment("API_URL"),
    );
  }
}

/// Environment definitions
enum Env {
  dev("DEV"),
  stage("STAGE"),
  prod("PROD");

  final String key;

  const Env(this.key);

  static Env fromString(String key) => Env.values.firstWhere((e) => e.key == key);
}

/// EnvConfig provider
final envConfigProvider = Provider<EnvConfig>((ref) {
  throw UnimplementedError();
});
