/// Environment definitions
enum Env {
  dev("DEV"),
  stage("STAGE"),
  prod("PROD");

  final String key;

  const Env(this.key);

  static Env fromString(String key) => Env.values.firstWhere((e) => e.key == key);
}
