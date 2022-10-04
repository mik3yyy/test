import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_custom_text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class ShareWithEmailContactScreen extends StatelessWidget {
  const ShareWithEmailContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
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
                Text(
                  'Add friends',
                  style: AppText.buttonText(
                    context,
                    AppColors.whiteColor,
                  ),
                ),
                CustomButton(
                  borderColor: AppColors.whiteColor,
                  buttonText: buttonText(context, "invite"),
                  bgColor: Colors.transparent,
                  textColor: AppColors.whiteColor,
                  buttonWidth: 66.w,
                ),
              ],
            ),
            Space(18.h),
            const WalletViewCustomTextFormField(
              hinText: 'Search friend',
              prefixIcon: Icon(Icons.search),
            ),
          ],
        ),
      ),
      child: Padding(
        padding:
            EdgeInsets.only(left: 25.w, right: 25.w, top: 71.w, bottom: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter email of friend to invite',
              style: AppText.body3(
                context,
                AppColors.appColor,
              ),
            ),
            Space(13.h),
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.referFriendBorderColor3,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(3.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.referFriendBorderColor3,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
            ),
            Space(190.h),
            CustomButton(
              borderColor: AppColors.appColor,
              buttonText: buttonText(context, "Invite"),
              bgColor: AppColors.appColor,
              textColor: AppColors.whiteColor,
              buttonWidth: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      ),
    );
  }
}
