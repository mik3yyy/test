enum Environment { staging, production }

class AppConfig {
  static Environment environment = Environment.staging;
  static const String stagingURL = "https://dev.kayndrexsphere.com/v1";
  static const String productionURL = "https://api.kayndrexsphere.com/v1";

  static final coreBaseUrl =
      environment == Environment.production ? productionURL : stagingURL;
}
