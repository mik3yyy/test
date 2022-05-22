import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/invite%20friend/widget/share_option_details.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_custom_text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class ShareToFriendsScreen extends StatelessWidget {
  const ShareToFriendsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GenericWidget(
      appbar: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          children: [
            Space(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (() => Navigator.pop(context)),
                  child: const Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.white,
                  ),
                ),
                // Icon(
                //   Icons.chevron_left,
                //   color: AppColors.whiteColor,
                //   size: 25.sp,
                // ),
                Text(
                  'Share to',
                  style: AppText.buttonText(
                    context,
                    AppColors.whiteColor,
                  ),
                ),
                const Space(0),
              ],
            ),
            Space(18.h),
            const WalletViewCustomTextFormField(
              hinText: 'Search friend',
              prefixIcon: Icon(Icons.search),
            ),
            Space(40.h)
          ],
        ),
      ),
      bgColor: AppColors.whiteColor,
      child: Container(
        height: 800.h,
        padding: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 20.w),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Space(80.h),
              Text(
                'Select how to share',
                style: AppText.body3(
                  context,
                  AppColors.appColor,
                ),
              ),
              Space(10.h),
              Container(
                height: 300.h,
                padding: const EdgeInsets.fromLTRB(14.0, 10.0, 14.0, 10.0),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    border: Border.all(
                      color: AppColors.borderColor,
                      width: 1.w,
                    ),
                    borderRadius: BorderRadius.circular(5.r)),
                child: const ShareOptionDetails(),
              ),
              Space(70.h),
              // Space(76.h),
              CustomButton(
                borderColor: AppColors.appColor,
                buttonText: 'Continue',
                bgColor: AppColors.appColor,
                textColor: AppColors.whiteColor,
                buttonWidth: MediaQuery.of(context).size.width,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
