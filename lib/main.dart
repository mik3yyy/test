import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/database/hive_setup.dart';
import 'package:kayndrexsphere_mobile/l10n/l10n.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/app_session/session_timeout_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/splash_screen/splash_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/languages/language_state.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/user_provider.dart';
import 'presentation/route/navigator.dart';
import 'presentation/screens/auth/app_session/session_config.dart';
import 'presentation/screens/auth/splash_screen/splash_screen.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  await DataBase.init();
  await PreferenceManager.init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //    final _navigatorKey = GlobalKey<NavigatorState>();
    // NavigatorState get _navigator => _navigatorKey.currentState!;
    final sessionConfig = SessionConfig(
        invalidateSessionForAppLostFocus: const Duration(minutes: 2),
        invalidateSessionForUserInactiviity: const Duration(minutes: 12));
    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
      if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
        // handle user  inactive timeout
        if (PreferenceManager.isloggedIn == true) {
          context.navigateReplaceRoot(const SigninScreen());
          PreferenceManager.removeToken();
          print("INACTIVE");
        } else {
          return;
        }
      } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        // handle user  app lost focus timeout
        if (PreferenceManager.isloggedIn == true) {
          context.navigateReplaceRoot(const SigninScreen());
          PreferenceManager.removeToken();
          print("APPFOCUS");
        } else {
          return;
        }
      }
    });
    final locale = ref.watch(localeProvider);
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => SessionTimeoutManager(
        sessionConfig: sessionConfig,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigator.key,
          title: 'Flutter Demo',
          theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xFFFFFFFF),
              primarySwatch: Colors.blue),
          locale: locale,
          supportedLocales: L10n.all,
          // localizationsDelegates: const [
          //   AppLocalizations.delegate, // Add this line
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          // ],

          // theme: theme,
          // home: const HomePage(),

          home: const SplashScreen(),

          builder: (context, widget) {
            //add this line
            ScreenUtil.setContext(context);
            return MediaQuery(
                //Setting font does not change with system font size
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!);
          },
          // theme: apptheme.appTheme
        ),
      ),
    );
  }
}

class SessionExpiredEvent {
  SessionExpiredEvent();
}
