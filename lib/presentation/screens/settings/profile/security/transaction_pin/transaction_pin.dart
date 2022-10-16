import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/profile.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/transaction_pin/change_transaction_pin.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/transaction_pin/forgot_transaction_pin.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../../components/app image/app_image.dart';
import '../../../../../components/app text theme/app_text_theme.dart';

class ChangeTransactionPin extends StatelessWidget {
  const ChangeTransactionPin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        title: const AppBarTitle(
            title: "Change Transaction Pin", color: Colors.black),
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
                      'Transaction PIN',
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
                      title: 'Forgotten Transaction PIN',
                      subTitle: 'Retrieve your forgotten transaction pin',
                      image: AppImage.transactionPin,
                      onPressed: () {
                        pushNewScreen(
                          context,
                          screen: ForgotTransactionPin(),
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                    ),
                    Space(10.h),
                    const Divider(
                      color: Colors.black,
                      thickness: 0.4,
                    ),
                    Space(20.h),
                    ProfileCard(
                      color: Colors.black,
                      title: 'Change Transaction PIN',
                      subTitle: 'Change your transaction PIN',
                      image: AppImage.resetTransactionPin,
                      onPressed: () {
                        pushNewScreen(
                          context,
                          screen: ResetTransactionPin(),
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                    ),
                    Space(10.h),
                    const Divider(
                      color: Colors.black,
                      thickness: 0.4,
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
