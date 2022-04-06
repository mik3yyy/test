import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/available_wallet.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../components/app image/app_image.dart';
import '../../components/app text theme/app_text_theme.dart';
import '../../components/reusable_widget.dart/custom_button.dart';

class WalletView extends StatefulWidget {
  const WalletView({Key? key}) : super(key: key);

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  int currentview = 0;
  List<Widget> pages = [];

  @override
  void initState() {
    pages.add(PageOne());
    pages.add(page2());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WalletViewWidget(
        appBar: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  // const Spacer(),
                  Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                  // Space(10.w),
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
        child: pages[currentview],
      ),
    );
  }

  Widget page1() {
    return SizedBox(
      height: 600.h,
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
                padding: const EdgeInsets.all(20),
                child: Image(
                    height: 30,
                    fit: BoxFit.contain,
                    color: AppColors.appColor.withOpacity(0.3),
                    image: const AssetImage(AppImage.bottomIcon2)),
              ),
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
                setState(() {
                  currentview = 0;
                });
              },
              buttonWidth: 320),
        ],
      ),
    );
  }

  Widget page2() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(60), topLeft: Radius.circular(60))),
      height: 400,
      width: double.maxFinite,
      child: Center(
        child: CustomButton(
            buttonText: 'Add Funds',
            bgColor: AppColors.appColor,
            borderColor: AppColors.appColor,
            textColor: Colors.white,
            onPressed: () {
              setState(() {
                currentview = 0;
              });
            },
            buttonWidth: 320),
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  const PageOne({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600.h,
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
                padding: const EdgeInsets.all(20),
                child: Image(
                    height: 30,
                    fit: BoxFit.contain,
                    color: AppColors.appColor.withOpacity(0.3),
                    image: const AssetImage(AppImage.bottomIcon2)),
              ),
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
                context.navigate(AvailableBalance());
              },
              buttonWidth: 320),
        ],
      ),
    );
  }
}

class PageTwo extends StatefulWidget {
  const PageTwo({
    Key? key,
  }) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600.h,
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
                padding: const EdgeInsets.all(20),
                child: Image(
                    height: 30,
                    fit: BoxFit.contain,
                    color: AppColors.appColor.withOpacity(0.3),
                    image: const AssetImage(AppImage.bottomIcon2)),
              ),
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
                setState(() {
                  // currentview = 1;
                });
              },
              buttonWidth: 320),
        ],
      ),
    );
  }
}
