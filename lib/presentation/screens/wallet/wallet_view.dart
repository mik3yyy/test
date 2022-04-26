import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/view_all_wallets.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../components/app image/app_image.dart';
import '../../components/app text theme/app_text_theme.dart';
import '../../components/reusable_widget.dart/custom_button.dart';

class WalletView extends StatefulWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  const WalletView(
      {Key? key,
      required this.menuScreenContext,
      required this.onScreenHideButtonPressed,
      required this.hideStatus})
      : super(key: key);

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  @override
  Widget build(BuildContext context) {
    return GenericWidget(
      appbar: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          children: [
            Space(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Wallets',
                      style: AppText.header1(context, Colors.white, 25.sp),
                    ),
                    Space(10.h),
                    Text(
                      'Lets you view your currency accounts',
                      style: AppText.body2(context, Colors.white, 20.sp),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 30.sp,
                ),
                Space(10.w),
                const CircleAvatar(
                  radius: 18.0,
                  backgroundImage: AssetImage(
                    AppImage.image1,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      child: SizedBox(
        height: 700.h,
        child: Column(
          children: [
            Space(150.h),
            Container(
              height: 110.h,
              width: 110.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.appColor.withOpacity(0.2),
              ),
              child: Center(
                child: Padding(
                    padding: const EdgeInsets.all(27),
                    child: SvgPicture.asset(
                      AppImage.wallet,
                      color: AppColors.appColor.withOpacity(0.3),
                    )),
              ),
            ),
            Space(30.h),
            Text(
              'You have no wallets',
              style: AppText.header2(context, AppColors.appColor, 25.sp),
            ),
            Space(15.h),
            Text(
              'Credit your account to get started',
              style: AppText.header2(
                  context, AppColors.appColor.withOpacity(0.3), 20.sp),
            ),
            Space(55.h),
            CustomButton(
                buttonText: 'Add Funds',
                bgColor: AppColors.appColor,
                borderColor: AppColors.appColor,
                textColor: Colors.white,
                onPressed: () {
                  pushNewScreen(
                    context,
                    screen: const ViewAllWallet(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.fade,
                  );
                  // context.navigate(AvailableBalance()

                  // );
                },
                buttonWidth: 320),
          ],
        ),
      ),
    );
  }
}
