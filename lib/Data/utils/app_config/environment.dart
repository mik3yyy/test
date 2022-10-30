enum Environment { dev, prod }

class AppConfig {
  static Environment environment = Environment.dev;
  static const String devURL = "https://dev.kayndrexsphere.com/v1";
  static const String productionURL = "https://api.kayndrexsphere.com/v1";

  static final coreBaseUrl =
      environment == Environment.prod ? productionURL : devURL;
}
