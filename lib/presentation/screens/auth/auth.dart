import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/auth_controller/auth_controller.dart';
import 'package:kayndrexsphere_mobile/Data/controller/auth_controller/auth_state_notifier.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/onboarding_screen/onboarding_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/splash_screen/splash_screen.dart';

class AuthHomePage extends StatelessWidget {
  const AuthHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final state = ref.watch(authControllerProvider);

      if (state is AuthAuthenticated) {
        return const SigninScreen();
      } else if (state is AuthUnauthenticated) {
        return const OnBoardingScreen();
      } else if (state is AuthLoading) {
        return const SplashScreen();
      } else {
        return const SplashScreen();
      }
    });
  }
}
