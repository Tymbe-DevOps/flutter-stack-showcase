class ApiConstants {
  static const bearer = 'Bearer';
  static const authorizationHeader = 'Authorization';

  static const appVersionCode = 'app-version-code';
  static const appVersionName = 'app-version-name';
  static const platform = 'platform';
  static const packageName = 'package-name';

  static const String baseProdUrl = "https://magicurl.com/api/v1/"; //TODO: Change to prod
  static const String baseStageUrl = "https://staging.magicurl.com/api/v1/"; //TODO: Change to dev / stage

  static const int timeoutInMs = 10000;

  static const Duration maxCacheAge = Duration(hours: 1);
}
