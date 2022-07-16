import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/auth.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3500,
      splash: Transform.scale(
        scale: 2,
        child: Image(
          image: const AssetImage("images/logo.png"),
          width: 400.w,
          height: 400.h,
        ),
      ),

      nextScreen: const AuthHomePage(),
      // splashTransition: SplashTransition.rotationTransition,
    );
  }
}
