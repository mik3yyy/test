import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/profile.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/email/ForgotEmail/forgot_email_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/email/change_email.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class EmailScreen extends StatefulHookConsumerWidget {
  const EmailScreen({Key? key}) : super(key: key);

  // const EmailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmailScreenState();
}

class _EmailScreenState extends ConsumerState<EmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.grey.shade100,
        title: const AppBarTitle(title: "Email", color: Colors.black),
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
          ),
          child: Column(
            children: [
              Space(30.h),
              ProfileCard(
                color: Colors.black,
                title: 'Forgotten email',
                subTitle: 'Reset your email if forgotten',
                image: AppImage.email,
                onPressed: () {
                  //TODO:remove comment from the code below
                  // pushNewScreen(
                  //   context,
                  //   screen:  ForgotEmailScreen(
                  //     forgotEmailRoute: ForgotEmailRoute.profile,
                  //   ),
                  //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  // );
                },
              ),
              Space(10.h),
              const Divider(
                thickness: 1,
              ),
              Space(10.h),
              ProfileCard(
                color: Colors.black,
                title: 'Change email',
                subTitle: 'Change your already existing email',
                image: AppImage.email,
                onPressed: () {
                  pushNewScreen(
                    context,
                    screen: const ChangeEmail(),
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
              ),
              Space(10.h),
              const Divider(
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
