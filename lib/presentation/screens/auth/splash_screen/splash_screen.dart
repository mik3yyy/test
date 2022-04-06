import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/onboarding_screen/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3500,
      splash: Image(
        image: const AssetImage("images/logo.png"),
        width: 400.w,
        height: 400.h,
      ),

      nextScreen: const OnBoardingScreen(),
      // splashTransition: SplashTransition.rotationTransition,
    );
  }
}
