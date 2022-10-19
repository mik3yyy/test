import 'dart:async';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/utils/app_config/environment.dart';
import 'package:kayndrexsphere_mobile/l10n/l10n.dart';
import 'package:kayndrexsphere_mobile/presentation/app_session/app_session.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/app_session/session_timeout_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/splash_screen/splash_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/languages/language_state.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/initialize_core/init_app_core.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:kayndrexsphere_mobile/third_party/sentry_analytics.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'presentation/route/navigator.dart';
import 'presentation/screens/auth/splash_screen/splash_screen.dart';
import 'presentation/utils/alert_dialog/show_unauthenicated_dialog.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
EventBus eventBus = EventBus();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeCore(environment: Environment.production);
  await initSentry(
      environment: Environment.production,
      runApp: () {
        eventBus.on<UnAuthenticated>().listen((event) async {
          navigator.key.currentContext!
              .navigateReplaceRoot(const SigninScreen());
          AuthenicatedState.showMessage(navigator.key.currentContext!,
              "Your session has timed out, please login again",
              buttonText: "Ok", buttonClicked: () {
            Navigator.pop(navigator.key.currentContext!);
            PreferenceManager.clear();
          });
        });
        runApp(const ProviderScope(child: MyApp()));
      });
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSession = ref.watch(appSessionConfigProvider);
    // final locale = ref.watch(localeProvider);
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => SessionTimeoutManager(
        sessionConfig: appSession,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigator.key,
          navigatorObservers: [
            SentryNavigatorObserver(),
          ],
          title: 'Flutter Demo',
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
          home: const SplashScreen(),
          builder: (context, widget) {
            //add this line
            ScreenUtil.setContext(context);
            return MediaQuery(
                //Setting font does not change with system font size
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!);
          },
        ),
      ),
    );
  }
}

class UnAuthenticated {
  UnAuthenticated();
}
