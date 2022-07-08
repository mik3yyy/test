import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/profile.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/change_password.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/transaction_pin/transaction_pin.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../components/app image/app_image.dart';
import '../../../../components/app text theme/app_text_theme.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Security',
          style: AppText.header2(context, Colors.black, 20.sp),
        ),
        leading: InkWell(
          onTap: (() => Navigator.pop(context)),
          child: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
          child: Column(
            children: [
              Space(20.h),
              ProfileCard(
                color: Colors.black,
                title: 'Password',
                subTitle: 'Change your already existing password',
                image: AppImage.password,
                onPressed: () {
                  pushNewScreen(
                    context,
                    screen: ChangePassword(),
                    pageTransitionAnimation: PageTransitionAnimation.fade,
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
                title: 'Transaction PIN',
                subTitle: 'Change or Retrieve forgotten transaction PIN',
                image: AppImage.transactionPin,
                onPressed: () {
                  pushNewScreen(
                    context,
                    screen: const ChangeTransactionPin(),
                    pageTransitionAnimation: PageTransitionAnimation.fade,
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
        ),
      ),
    );
  }
}
