import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import 'widget/add_fund_container_widget.dart';

class AddFundsToWalletScreen extends StatelessWidget {
  const AddFundsToWalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0XFF072777).withOpacity(0.03),
      // backgroundColor: const Color.fromRGBO(7, 39, 119, 0.01),
      // backgroundColor: const Color.fromRGBO(7, 39, 119, 0.08),
      // backgroundColor: const Color(0XFF757575),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: Icon(
          Icons.chevron_left,
          color: AppColors.textColor,
          size: 60.sp,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 4.w, bottom: 4.w),
              width: MediaQuery.of(context).size.width,
              height: 32.h,
              decoration: BoxDecoration(
                color: AppColors.textColor.withOpacity(0.05),
              ),
              child: Center(
                child: Text(
                  'Add funds to your wallet',
                  style: AppText.body6(
                    context,
                    AppColors.textColor.withOpacity(0.7),
                    15.sp,
                  ),
                ),
              ),
            ),
            Space(27.h),
            AppFundContainerWidget(
              image: AppImage.debitCardIcon,
              text: 'Credit/Debit Card',
              onTap: () {
                //TODO: To implement debit card method
              },
            ),
            Space(10.h),
            AppFundContainerWidget(
              //TODO: To get image later, they are grouped together in the figma file
              image: AppImage.debitCardIcon,
              text: 'Pay',
              onTap: () {
                //TODO: To implement pay method
              },
            ),
            Space(10.h),
            AppFundContainerWidget(
              //TODO: To get image later, they are grouped together in the figma file
              image: AppImage.debitCardIcon,
              text: 'Google Pay',
              onTap: () {
                //TODO: To implement Google Pay method
              },
            ),
          ],
        ),
      ),
    );
  }
}
