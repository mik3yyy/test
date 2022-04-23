import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/create_acount/currency.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/splash_screen/splash_screen.dart';

import 'package:kayndrexsphere_mobile/presentation/screens/auth/transaction_pin/transaction_pin.dart';

import 'package:kayndrexsphere_mobile/presentation/screens/notification/notification_setting_screen.dart';

import 'package:kayndrexsphere_mobile/presentation/screens/prop/message_screen.dart';

import 'presentation/route/navigator.dart';
import 'presentation/screens/notification/notification_screen.dart';
import 'presentation/route/navigator.dart';
import 'presentation/screens/auth/splash_screen/splash_screen.dart';
import 'presentation/screens/home/widgets/main_screen.dart';
import 'presentation/screens/prop/chat_setting_screen.dart';
import 'presentation/screens/prop/contact_list_prop_screen.dart';

void main() {
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

        // CurrencyScreen(),
        // const CurrencyScreen(),
        //  const BottomNavBar(),

        home: MainScreen(menuScreenContext: context),

        // const SplashScreen(),

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
