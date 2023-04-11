import 'dart:async';
import 'package:event_bus/event_bus.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/utils/app_config/environment.dart';

import 'package:kayndrexsphere_mobile/presentation/app_session/app_session.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/app_session/session_timeout_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/auth.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/initialize_core/init_app_core.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'presentation/route/navigator.dart';
import 'presentation/utils/alert_dialog/show_unauthenicated_dialog.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
EventBus eventBus = EventBus();
Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initializeCore(environment: Environment.dev);
  runZonedGuarded<Future<void>>(() async {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    final sessionStateStream = StreamController<SessionState>();
    eventBus.on<UnAuthenticated>().listen((event) async {
      if (PreferenceManager.authToken.isEmpty) {
        return;
      } else {
        navigator.key.currentContext!.navigateReplaceRoot(const SigninScreen());
        AuthenicatedState.showMessage(navigator.key.currentContext!,
            "Your session has timed out, please login again", buttonText: "Ok",
            buttonClicked: () {
          Navigator.pop(navigator.key.currentContext!);
          sessionStateStream.add(SessionState.stopListening);
          PreferenceManager.clear();
        });
      }
    });

    runApp(const ProviderScope(child: MyApp()));
  }, (error, stack) {
    debugPrintStack(stackTrace: stack);
    if (kDebugMode) {
      print(error);
    }
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
  // await initSentry(
  //     environment: Environment.dev,
  //     runApp: () {
  //       eventBus.on<UnAuthenticated>().listen((event) async {
  //         navigator.key.currentContext!
  //             .navigateReplaceRoot(const SigninScreen());
  //         AuthenicatedState.showMessage(navigator.key.currentContext!,
  //             "Your session has timed out, please login again",
  //             buttonText: "Ok", buttonClicked: () {
  //           Navigator.pop(navigator.key.currentContext!);
  //           PreferenceManager.clear();
  //         });
  //       });
  //       runApp(const ProviderScope(child: MyApp()));
  //     });
}

class MyApp extends StatefulHookConsumerWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000), () async {
      FlutterNativeSplash.remove();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appSession = ref.watch(appSessionConfigProvider);
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: ((context, child) {
          return SessionTimeoutManager(
            sessionConfig: appSession,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: navigator.key,
              // navigatorObservers: [
              //   // FirebaseAnalyticsObserver(analytics: analytics),
              // ],
              title: 'Kayndrexsphere',
              theme: ThemeData(
                  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
                  primarySwatch: Colors.blue),
              // locale: locale,
              // supportedLocales: L10n.all,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,

                // AppLocalizations.delegate, // Add this line
              ],
              home: const AuthHomePage(),
              builder: (context, widget) {
                //add this line
                // ScreenUtil.setContext(context);
                return MediaQuery(
                    //Setting font does not change with system font size
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: widget!);
              },
            ),
          );
        }));
  }
}

class UnAuthenticated {
  UnAuthenticated();
}
