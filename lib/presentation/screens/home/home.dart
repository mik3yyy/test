import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../components/app image/app_image.dart';
import '../../components/app text theme/app_text_theme.dart';
import '../wallet/invest/invest.dart';
import '../wallet/transfer/transfer.dart';
import '../wallet/withdrawal/withdraw.dart';
import 'widgets/bottomNav/persistent-tab-view.dart';

class HomePage extends StatelessWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  const HomePage(
      {Key? key,
      required this.menuScreenContext,
      required this.onScreenHideButtonPressed,
      required this.hideStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // endDrawer: const NavigationDrawer(),
        body: Builder(builder: (context) {
      return WalletViewWidget(
        appBar: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Hi Dave',
                          style: AppText.header1(context, Colors.white, 25.sp),
                        ),
                        Space(10.h),
                        Text(
                          'Thanks for signing up with us',
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
                Space(30.h),
                Container(
                  height: 150.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: AppColors.bottomSheet,
                  ),
                  child: Column(
                    children: [
                      Space(12.h),
                      Text(
                        'Available Balance',
                        style: AppText.body2(context,
                            AppColors.appColor.withOpacity(0.3), 20.sp),
                      ),
                      Space(20.h),
                      Text(
                        '\$ 200.00',
                        style:
                            AppText.header1(context, AppColors.appColor, 40.sp),
                      ),
                      Space(15.h),
                      Text(
                        'Acc No: 23456789',
                        style:
                            AppText.body2(context, AppColors.appColor, 20.sp),
                      ),
                    ],
                  ),
                )
                // Space(30.h),
                // const WalletOptionList()
              ],
            ),
          ),
        ),
        child: SizedBox(
          height: 550.h,
          child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      MenuCards(
                        title: 'Transfer',
                        image: AppImage.transfer,
                        onPressed: () {
                          pushNewScreen(
                            context, screen: const Transfer(),
                            withNavBar:
                                true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                                PageTransitionAnimation.fade,
                          );
                        },
                      ),
                      const Spacer(),
                      MenuCards(
                        title: 'Add funds',
                        image: AppImage.addFunds,
                        onPressed: () {},
                      )
                    ],
                  ),
                  Space(30.h),
                  Row(
                    children: [
                      MenuCards(
                        title: 'Start investing',
                        image: AppImage.startInvestin,
                        onPressed: () {
                          pushNewScreen(
                            context, screen: const InvestScreen(),
                            withNavBar:
                                true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                                PageTransitionAnimation.fade,
                          );
                        },
                      ),
                      const Spacer(),
                      MenuCards(
                        title: 'Withdraw',
                        image: AppImage.withdraw,
                        onPressed: () {
                          pushNewScreen(
                            context,
                            screen: const Withdraw(),
                            withNavBar:
                                true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                                PageTransitionAnimation.fade,
                          );
                        },
                      )
                    ],
                  )
                ],
              )),
        ),
      );
    }));
  }
}

class MenuCards extends StatelessWidget {
  final String title;
  final String image;
  final void Function()? onPressed;
  const MenuCards(
      {Key? key,
      required this.title,
      required this.image,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 210.h,
        width: 180.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            color: AppColors.appColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Space(5.h),
            SvgPicture.asset(
              image,
              color: Colors.white,
              height: 50.h,
              width: 50.w,
            ),
            Space(25.h),
            Text(
              title,
              style: AppText.header2(context, Colors.white, 25.sp),
            ),
          ],
        ),
      ),
    );
  }
}
