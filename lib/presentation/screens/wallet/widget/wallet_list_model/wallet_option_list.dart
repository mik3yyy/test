import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_list_model/wallet_options.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/withdraw.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../components/app text theme/app_text_theme.dart';
import '../../../home/widgets/bottomNav/persistent-tab-view.dart';

class WalletOptionList extends StatelessWidget {
  const WalletOptionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 110.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  height: 70.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 2.w, color: AppColors.bottomSheet)),
                  child: const Image(image: AssetImage(AppImage.transfer)),
                ),
                Space(10.h),
                Text(
                  'Transfer',
                  style: AppText.body2(context, Colors.white, 16.sp),
                )
              ],
            ),
            /////
            Column(
              children: [
                Container(
                  height: 70.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 2.w, color: AppColors.bottomSheet)),
                  child: const Image(image: AssetImage(AppImage.addFunds)),
                ),
                Space(10.h),
                Text(
                  'Add wallet',
                  style: AppText.body2(context, Colors.white, 16.sp),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  height: 70.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 2.w, color: AppColors.bottomSheet)),
                  child: const Image(image: AssetImage(AppImage.invest)),
                ),
                Space(10.h),
                Text(
                  'Invest',
                  style: AppText.body2(context, Colors.white, 16.sp),
                )
              ],
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    pushNewScreen(
                      context,
                      screen: const Withdraw(),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  },
                  child: Container(
                    height: 70.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2.w, color: AppColors.bottomSheet)),
                    child: const Image(image: AssetImage(AppImage.withdraw)),
                  ),
                ),
                Space(10.h),
                Text(
                  'Withdraw',
                  style: AppText.body2(context, Colors.white, 16.sp),
                )
              ],
            ),
          ],
        ));
  }
}
