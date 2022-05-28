import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app image/app_image.dart';
import '../../../components/app text theme/app_text_theme.dart';

class AvailableWallet extends StatefulWidget {
  const AvailableWallet({
    Key? key,
  }) : super(key: key);

  @override
  State<AvailableWallet> createState() => _AvailableWalletState();
}

class _AvailableWalletState extends State<AvailableWallet> {
  @override
  Widget build(BuildContext context) {
    return GenericWidget(
      appbar: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Space(20.h),
            InkWell(
              onTap: (() => Navigator.pop(context)),
              child: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
              ),
            ),
            Space(20.h),
            const Center(
              child: CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage(
                  AppImage.image1,
                ),
              ),
            )
          ],
        ),
      ),
      bgColor: AppColors.whiteColor,
      child: SizedBox(
        height: 700.h,
        child: Padding(
          padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 45.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Available wallets',
                style: AppText.header2(context, AppColors.appColor, 20.sp),
              ),
              Space(20.h),
              Container(
                height: 100.h,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(width: 1, color: AppColors.appColor)),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dollar wallet',
                          style: AppText.header2(
                              context, AppColors.appColor, 20.sp),
                        ),
                        Space(10.h),
                        Text(
                          '\$ 200.00',
                          style: AppText.header2(
                              context, AppColors.appColor, 20.sp),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: const [
                        Icon(
                          Icons.circle_outlined,
                          color: Colors.black,
                          size: 6,
                        ),
                        Space(3),
                        Icon(
                          Icons.circle_outlined,
                          color: Colors.black,
                          size: 6,
                        ),
                        Space(3),
                        Icon(
                          Icons.circle_outlined,
                          color: Colors.black,
                          size: 6,
                        ),
                      ],
                    )
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
