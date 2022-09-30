import 'package:flutter/material.dart';
import 'package:kayndrexsphere_mobile/Data/utils/app_config/environment.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> initSentry(
    {required Environment environment, required VoidCallback runApp}) async {
  AppConfig.environment = environment;
  await SentryFlutter.init(
    (options) {
      options.enableNativeCrashHandling = true;
      options.attachStacktrace = true;
      options.enableNativeCrashHandling = true;
      options.dsn =
          'https://bb4405e0a65e4af1b4eec99ce2129983@o1231006.ingest.sentry.io/6726566';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
      options.environment = AppConfig.environment.toString();
    },
    appRunner: runApp,
  );
}
