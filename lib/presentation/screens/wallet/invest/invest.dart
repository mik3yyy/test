import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app image/app_image.dart';
import '../../../components/app text theme/app_text_theme.dart';

class InvestScreen extends StatelessWidget {
  // final BuildContext menuScreenContext;
  // final Function onScreenHideButtonPressed;
  // final bool hideStatus;
  const InvestScreen({
    Key? key,
    // required this.menuScreenContext,
    // required this.onScreenHideButtonPressed,
    // required this.hideStatus
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GenericWidget(
      appbar: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
        child: Column(
          children: [
            Space(20.h),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (() => Navigator.pop(context)),
                  child: const Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.white,
                  ),
                ),
                Space(15.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Hello Dee,',
                      style: AppText.header1(context, Colors.white, 25.sp),
                    ),
                    Space(10.h),
                    Text(
                      'Let’s get going with investments',
                      style: AppText.body2(context, Colors.white, 18.sp),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 20.sp,
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

            // const WalletOptionList()
          ],
        ),
      ),
      bgColor: AppColors.whiteColor,
      child: SizedBox(
        height: 700.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppImage.investIcon,
              height: 120.h,
              width: 120.w,
            ),
            Space(20.h),
            Text(
              'Start investing',
              style: AppText.body2(
                  context, AppColors.appColor.withOpacity(0.4), 25.sp),
            ),
          ],
        ),
      ),
    );
  }
}
