import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/invite%20friend/widget/contact_list_build.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_custom_text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class ShareWithPhoneContactScreen extends StatelessWidget {
  const ShareWithPhoneContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    // bool newValue = false;
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
                  buttonText: buttonText(context, "Invite"),
                  bgColor: Colors.transparent,
                  textColor: AppColors.whiteColor,
                  buttonWidth: 66.w,
                ),
              ],
            ),
            Space(18.h),
            WalletViewCustomTextFormField(
              controller: controller,
              hinText: 'Search friend',
              prefixIcon: const Icon(Icons.search),
            ),
          ],
        ),
      ),
      child: Padding(
        padding:
            EdgeInsets.only(left: 25.w, right: 25.w, top: 25.w, bottom: 20.w),
        child:
            //THIS IS THE CONTACTS LIST VIEW BUILD
            // const ContactListBuild(),

            //THIS IS JUST A RANDOM BUILD
            Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(AppImage.phoneContactImg1),
                    Space(4.w),
                    Text(
                      'Amari SA',
                      style: AppText.contactNameStyle(
                        context,
                        AppColors.appColor,
                      ),
                    ),
                  ],
                ),
                const ContactChecBox()
              ],
            ),
            const Divider(
              color: Color.fromRGBO(7, 39, 119, 0.2),
              thickness: 1.5,
              height: 30,
              // indent: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(AppImage.phoneContactImg1),
                    Space(4.w),
                    Text(
                      'Amari SA',
                      style: AppText.contactNameStyle(
                        context,
                        AppColors.appColor,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.check_box_outline_blank_outlined),
              ],
            ),
            const Divider(
              color: Color.fromRGBO(7, 39, 119, 0.2),
              thickness: 1.5,
              height: 30,
              // indent: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(AppImage.phoneContactImg1),
                    Space(4.w),
                    Text(
                      'Amari SA',
                      style: AppText.contactNameStyle(
                        context,
                        AppColors.appColor,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.check_box_outline_blank_outlined),
              ],
            ),
            const Divider(
              color: Color.fromRGBO(7, 39, 119, 0.2),
              thickness: 1.5,
              height: 30,
              // indent: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(AppImage.phoneContactImg1),
                    Space(4.w),
                    Text(
                      'Amari SA',
                      style: AppText.contactNameStyle(
                        context,
                        AppColors.appColor,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.check_box_outline_blank_outlined),
              ],
            ),
            const Divider(
              color: Color.fromRGBO(7, 39, 119, 0.2),
              thickness: 1.5,
              height: 30,
              // indent: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(AppImage.phoneContactImg1),
                    Space(4.w),
                    Text(
                      'Amari SA',
                      style: AppText.contactNameStyle(
                        context,
                        AppColors.appColor,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.check_box_outline_blank_outlined),
              ],
            ),
            const Divider(
              color: Color.fromRGBO(7, 39, 119, 0.2),
              thickness: 1.5,
              height: 30,
              // indent: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(AppImage.phoneContactImg1),
                    Space(4.w),
                    Text(
                      'Amari SA',
                      style: AppText.contactNameStyle(
                        context,
                        AppColors.appColor,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.check_box_outline_blank_outlined),
              ],
            ),
            const Divider(
              color: Color.fromRGBO(7, 39, 119, 0.2),
              thickness: 1.5,
              height: 30,
              // indent: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(AppImage.phoneContactImg1),
                    Space(4.w),
                    Text(
                      'Amari SA',
                      style: AppText.contactNameStyle(
                        context,
                        AppColors.appColor,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.check_box_outline_blank_outlined),
              ],
            ),
            const Divider(
              color: Color.fromRGBO(7, 39, 119, 0.2),
              thickness: 1.5,
              height: 30,
              // indent: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(AppImage.phoneContactImg1),
                    Space(4.w),
                    Text(
                      'Amari SA',
                      style: AppText.contactNameStyle(
                        context,
                        AppColors.appColor,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.check_box_outline_blank_outlined),
              ],
            ),
            const Divider(
              color: Color.fromRGBO(7, 39, 119, 0.2),
              thickness: 1.5,
              height: 30,
              // indent: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(AppImage.phoneContactImg1),
                    Space(4.w),
                    Text(
                      'Amari SA',
                      style: AppText.contactNameStyle(
                        context,
                        AppColors.appColor,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.check_box_outline_blank_outlined),
              ],
            ),
            const Divider(
              color: Color.fromRGBO(7, 39, 119, 0.2),
              thickness: 1.5,
              height: 30,
              // indent: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}
