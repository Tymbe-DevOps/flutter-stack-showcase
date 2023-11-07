enum AppRoute {
  splash("/splash"),
  dashboard("/dashboard"),
  scanner("/scanner"),
  login("/login"),
  register("/register");

  final String path;
  const AppRoute(this.path);
}

extension AppRouteExt on AppRoute {
  /// Returns the route name without the leading slash
  String get routeName => path.replaceFirst("/", "");
}
