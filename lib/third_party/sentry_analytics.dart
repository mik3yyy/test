import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

Future<void> initCrashAnalytics({required VoidCallback runApp}) async {
  runZonedGuarded<Future<void>>(() async {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    runApp;
  }, (error, stack) {
    debugPrintStack(stackTrace: stack);
    if (kDebugMode) {
      print(error);
    }
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
  // await SentryFlutter.init(
  //   (options) {
  //     options.enableNativeCrashHandling = true;
  //     options.attachStacktrace = true;
  //     options.enableNativeCrashHandling = true;
  //     options.dsn =
  //         'https://bb4405e0a65e4af1b4eec99ce2129983@o1231006.ingest.sentry.io/6726566';
  //     // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
  //     // We recommend adjusting this value in production.
  //     options.tracesSampleRate = 1.0;
  //     options.environment = AppConfig.environment.toString();
  //   },
  //   appRunner: runApp,
  // );
}
