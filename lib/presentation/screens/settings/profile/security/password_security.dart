import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/forget_password/forget_password.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/profile.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/change_password.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class ChangePasswordSecurity extends StatelessWidget {
  const ChangePasswordSecurity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.grey.shade100,
        title: const AppBarTitle(title: "Change Password", color: Colors.black),
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 40.h,
                width: MediaQuery.of(context).size.width,
                color: AppColors.appColor.withOpacity(0.1),
                child: Padding(
                  padding: EdgeInsets.only(right: 240.w),
                  child: Center(
                    child: Text(
                      'Password',
                      style: AppText.body2(context, Colors.black54, 20.sp),
                    ),
                  ),
                ),
              ),
              Space(30.h),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                child: Column(
                  children: [
                    ProfileCard(
                      color: Colors.black,
                      title: 'Forgotten Password',
                      subTitle: 'Retrieve your forgotten password',
                      image: AppImage.transactionPin,
                      onPressed: () {
                        pushNewScreen(
                          context,
                          screen: ForgotPasswordScreen(),
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                    ),
                    Space(10.h),
                    const Divider(
                      thickness: 1,
                    ),
                    Space(20.h),
                    ProfileCard(
                      color: Colors.black,
                      title: 'Change Password',
                      subTitle: 'Change your password',
                      image: AppImage.resetTransactionPin,
                      onPressed: () {
                        pushNewScreen(
                          context,
                          screen: ChangePassword(),
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                    ),
                    Space(10.h),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
