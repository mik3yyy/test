import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/database/hive_setup.dart';
import 'package:kayndrexsphere_mobile/Data/utils/error_state.dart';
import 'package:kayndrexsphere_mobile/l10n/l10n.dart';
import 'package:kayndrexsphere_mobile/presentation/app_session/app_session.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/app_session/session_timeout_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/splash_screen/splash_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/languages/language_state.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/user_provider.dart';
import 'Data/constant/constant.dart';
import 'presentation/route/navigator.dart';
import 'presentation/screens/auth/splash_screen/splash_screen.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
EventBus eventBus = EventBus();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = Constants.stripePublishableKey;
  // Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  await Stripe.instance.applySettings();
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
    final appSession = ref.watch(appSessionConfigProvider);
    //* Agba refactor this code biko
    eventBus.on<ErrorState>().listen((event) async {
      final result = await showOkAlertDialog(
        context: navigator.key.currentContext!,
        title: 'Expired session',
        message: 'Session has expired. Please login to authenticate this user',
        barrierDismissible: false,
      );
      if (result == OkCancelResult.ok) {
        Navigator.pop(navigator.key.currentContext!);
        navigator.key.currentContext!.navigateReplaceRoot(const SigninScreen());
        PreferenceManager.removeToken();
      }
    });
    final locale = ref.watch(localeProvider);
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => SessionTimeoutManager(
        sessionConfig: appSession,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigator.key,
          title: 'Flutter Demo',
          theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xFFFFFFFF),
              primarySwatch: Colors.blue),
          locale: locale,
          supportedLocales: L10n.all,
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            // AppLocalizations.delegate, // Add this line
            // GlobalMaterialLocalizations.delegate,
            // GlobalWidgetsLocalizations.delegate,
            // GlobalCupertinoLocalizations.delegate,
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
          // theme: apptheme.appTheme
        ),
      ),
    );
  }
}

class SessionExpiredEvent {
  SessionExpiredEvent();
}
