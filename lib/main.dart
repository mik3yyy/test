import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/auth.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/splash_screen/splash_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'presentation/route/navigator.dart';
import 'presentation/screens/auth/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceManager.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigator.key,
        title: 'Flutter Demo',
        theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFFFFFFF),
            primarySwatch: Colors.blue),

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
    );
  }
}
