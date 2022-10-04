import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_custom_text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class AddFaqQuestion extends StatelessWidget {
  const AddFaqQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WalletViewWidget(
      appBar: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.chevron_left,
                  color: AppColors.whiteColor,
                  size: 25.sp,
                ),
                Column(
                  children: [
                    Text(
                      'FAQ',
                      style: AppText.buttonText(
                        context,
                        AppColors.whiteColor,
                      ),
                    ),
                    Space(6.h),
                    Text(
                      'Frequently asked questions',
                      style: AppText.body3(
                        context,
                        AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
                const Space(0),
              ],
            ),
            Space(18.h),
            const WalletViewCustomTextFormField(
              hinText: 'Search FAQ',
              prefixIcon: Icon(Icons.search),
            ),
          ],
        ),
      ),
      //THe bottomsheet is expanding that is covering the appbar
      child: Padding(
        // child: SingleChildScrollView(
        padding:
            EdgeInsets.only(left: 25.w, right: 25.w, top: 20.w, bottom: 20.w),
        child: Column(
          children: [
            Text(
              'Add answers',
              style: AppText.body3(context, AppColors.appColor),
            ),
            Space(15.h),
            TextFormField(
              // controller: controller,
              decoration: InputDecoration(
                hintText: 'How do I make withdrawals?',
                filled: true,
                fillColor: AppColors.faqFilledColor,
                hintStyle: AppText.body3(
                  context,
                  AppColors.appColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.faqFilledColor,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.faqFilledColor,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            Space(21.h),
            Container(
              height: 371.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.faqFilledColor,
                border: Border.all(
                  width: 0.4,
                  color: AppColors.faqFilledColor,
                ),
              ),
              child: TextFormField(
                // controller: controller,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Add answer',
                  hintStyle: AppText.body3(
                    context,
                    AppColors.faqHintTextColor2,
                  ),
                ),
              ),
            ),
            Space(67.h),
            CustomButton(
              borderColor: AppColors.buttonInactivecolor,
              buttonText: buttonText(context, "Post"),
              bgColor: AppColors.buttonInactivecolor,
              textColor: AppColors.whiteColor,
              buttonWidth: MediaQuery.of(context).size.width,
            ),
            Space(16.h),
            Text(
              'Cancel',
              style: AppText.body3(context, AppColors.faqCancelTextColor),
            )
          ],
        ),
      ),
    );
  }
}
