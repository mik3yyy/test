import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/bottom_bar/bottom_bar.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/home.dart';

import 'presentation/route/navigator.dart';

void main() {
  runApp(const MyApp());
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
        home: const BottomNavBar(),
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
    ;
  }
}
