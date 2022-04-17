import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/transfer/transfer.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import '../../components/app image/app_image.dart';
import '../../components/app text theme/app_text_theme.dart';
import 'widget/wallet_view_widget.dart';

class ViewAllWallet extends StatelessWidget {
  const ViewAllWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WalletViewWidget(
        appBar: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (() => Navigator.pop(context)),
                    child: const Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Center(
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: AssetImage(
                        AppImage.image1,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        child: SizedBox(
          height: 700.h,
          child: Padding(
            padding: EdgeInsets.only(left: 35.w, right: 35.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Space(30.h),
                Text(
                  'View available wallets',
                  style: AppText.body2(context, AppColors.appColor, 25.sp),
                ),
                Space(30.h),
                InkWell(
                  onTap: () {
                    pushNewScreen(
                      context,
                      screen: const Transfer(),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.r),
                      color: AppColors.whiteColor,
                      border: Border.all(
                          width: 2.w,
                          color: AppColors.appColor.withOpacity(0.2)),
                      // color: AppColors.appColor.withOpacity(0.2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Dollar Account',
                          style:
                              AppText.body2(context, AppColors.appColor, 20.sp),
                        ),
                        Space(10.h),
                        Text(
                          '\$  200.00',
                          style:
                              AppText.body2(context, AppColors.appColor, 25.sp),
                        ),
                      ],
                    ),
                  ),
                ),
                Space(20.h),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.r),
                    color: AppColors.whiteColor,
                    border: Border.all(
                        width: 2.w, color: AppColors.appColor.withOpacity(0.2)),
                    // color: AppColors.appColor.withOpacity(0.2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Pound Sterling Account',
                        style:
                            AppText.body2(context, AppColors.appColor, 20.sp),
                      ),
                      Space(10.h),
                      Text(
                        '\$  300.00',
                        style:
                            AppText.body2(context, AppColors.appColor, 25.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
