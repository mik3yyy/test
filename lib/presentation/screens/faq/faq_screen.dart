import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/faq/widget/faq_accordion.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/faq/widget/faq_tab_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

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
            SizedBox(
                height: 46.h,
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: AppColors.whiteColor,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color.fromRGBO(216, 216, 216, 0.8),
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color.fromRGBO(216, 216, 216, 0.8),
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                )
                // TextFormField(
                //   decoration: fieldInputDecoration(
                //     fillColor: AppColors.whiteColor,
                //     hintText: 'Search FAQ',
                //   ),
                // ),
                )
          ],
        ),
      ),
      child: Padding(
        padding:
            EdgeInsets.only(left: 25.w, right: 25.w, top: 20.w, bottom: 20.w),
        child: Column(
          children: [
            const FaqTabButton(
              icon: AppImage.faq1,
              text: 'Getting Started',
              bgColor: AppColors.appColor,
            ),
            Space(11.h),
            const FaqTabButton(
              icon: AppImage.faq2,
              text: 'Knowledge Base',
              bgColor: AppColors.inActiveColor,
            ),
            Space(11.h),
            const FaqTabButton(
              icon: AppImage.faq3,
              text: 'Kayndrexsphere forum',
              bgColor: AppColors.inActiveColor,
            ),
            Space(43.h),
            const Divider(
              color: Color.fromRGBO(7, 39, 119, 0.2),
              thickness: 1.5,
              height: 20,
              // indent: 5.0,
            ),
            FaqAccodrionExpandable(
              headerTitle: 'Learn about kayndrexsphere',
              child: Column(
                children: [
                  Space(5.h),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Massa porta dignissim in sagittis varius lacinia.',
                    style: AppText.body2(
                      context,
                      const Color.fromRGBO(7, 39, 119, 0.7),
                      18.sp,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color.fromRGBO(7, 39, 119, 0.2),
              thickness: 1.5,
              height: 20,
              // indent: 5.0,
            ),
            FaqAccodrionExpandable(
              headerTitle: 'Investment options in kayndrexsphere',
              child: Column(
                children: [
                  Space(5.h),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Massa porta dignissim in sagittis varius lacinia.',
                    style: AppText.body2(
                      context,
                      const Color.fromRGBO(7, 39, 119, 0.7),
                      18.sp,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color.fromRGBO(7, 39, 119, 0.2),
              thickness: 1.5,
              height: 20,
              // indent: 5.0,
            ),
            FaqAccodrionExpandable(
              headerTitle: 'Is kayndrexsphere trustworthy?',
              child: Column(
                children: [
                  Space(5.h),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Massa porta dignissim in sagittis varius lacinia.',
                    style: AppText.body2(
                      context,
                      const Color.fromRGBO(7, 39, 119, 0.7),
                      18.sp,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color.fromRGBO(7, 39, 119, 0.2),
              thickness: 1.5,
              height: 20,
              // indent: 5.0,
            ),
            FaqAccodrionExpandable(
              headerTitle: 'What is the alpha investment?',
              child: Column(
                children: [
                  Space(5.h),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Massa porta dignissim in sagittis varius lacinia.',
                    style: AppText.body2(
                      context,
                      const Color.fromRGBO(7, 39, 119, 0.7),
                      18.sp,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color.fromRGBO(7, 39, 119, 0.2),
              thickness: 1.5,
              height: 20,
              // indent: 5.0,
            ),
            FaqAccodrionExpandable(
              headerTitle: 'How do I earn more kayndrex?',
              child: Column(
                children: [
                  Space(5.h),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Massa porta dignissim in sagittis varius lacinia.',
                    style: AppText.body2(
                      context,
                      const Color.fromRGBO(7, 39, 119, 0.7),
                      18.sp,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color.fromRGBO(7, 39, 119, 0.2),
              thickness: 1.5,
              height: 20,
              // indent: 5.0,
            ),
            FaqAccodrionExpandable(
              headerTitle: 'Recover lost account',
              child: Column(
                children: [
                  Space(5.h),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Massa porta dignissim in sagittis varius lacinia.',
                    style: AppText.body2(
                      context,
                      const Color.fromRGBO(7, 39, 119, 0.7),
                      18.sp,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color.fromRGBO(7, 39, 119, 0.2),
              thickness: 1.5,
              height: 20,
              // indent: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}


// );



//  

// Blandit tempus aenean consequat risus, congue. 

// Odio volutpat sed fames augue. Duis pretium vitae non vulputate tristique vel, sagittis id. Id congue sed in.