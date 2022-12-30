// import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/auth_controller/auth_controller.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/auth.dart';

class SplashScreen extends StatefulHookConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    ref.read(authControllerProvider.notifier).getAuth();

    Future.delayed(const Duration(milliseconds: 3000), () async {
      context.navigateReplaceRoot(const AuthHomePage());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image(
                image: const AssetImage("assets/images/splashLogo.jpeg"),
                width: 250.w,
                height: 250.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}







// class SplashScreen extends HookConsumerWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, ref) {
//     useEffect(() {
//       ref.read(authControllerProvider.notifier).getAuth();
//       return null;
//     }, const []);
//     return AnimatedSplashScreen(
//       duration: 3500,
//       animationDuration: const Duration(milliseconds: 500),
//       splash: Transform.scale(
//         scale: 2,
//         child: Image(
//           image: const AssetImage("assets/images/splashLogo.jpeg"),
//           width: 400.w,
//           height: 400.h,
//         ),
//       ),

//       nextScreen: const AuthHomePage(),
//       // splashTransition: SplashTransition.rotationTransition,
//     );
//   }
// }
