import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/invite%20friend/share_to_friends_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class InviteFriendScreen extends StatelessWidget {
  const InviteFriendScreen({Key? key}) : super(key: key);

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
                InkWell(
                  onTap: (() => Navigator.pop(context)),
                  child: const Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Refer friend',
                  style: AppText.body2(context, AppColors.whiteColor, 20.sp),
                ),
                const Space(0),
              ],
            ),
            Space(46.h),
            Text(
              '1 Referral = 0.001 Kayndrex',
              style: AppText.body2(context, AppColors.whiteColor, 19.sp),
            ),
            Space(2.h),
            Text(
              'You can refer a friend to earn kayndrex',
              style: AppText.body2(context, AppColors.whiteColor, 19.sp),
            ),
          ],
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(
          left: 25.w,
          right: 25.w,
        ),
        height: 650.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Space(30.h),
            Image.asset(
              AppImage.inviteFriendImg,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              // width: 318.w,
              // height: 230.h,
            ),
            // SvgPicture.asset(
            //   AppImage.inviteFriend,
            //   // height: 500.h,
            //   // width: 500.w,
            // ),
            Space(33.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Referral code',
                  style: AppText.header2(context, AppColors.appColor, 20.sp),
                ),
                Space(5.h),
                DottedBorder(
                  strokeWidth: 2.w,
                  radius: Radius.circular(5.r),
                  color: AppColors.referFriendBorderColor,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.r)),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(21.h, 18.h, 21.h, 18.h),
                      height: 54.h,
                      decoration: const BoxDecoration(
                          color: AppColors.referFriendBgColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'EK - 3647U',
                            style: AppText.body3(
                              context,
                              AppColors.appColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              //TODO: To perform copy to clipboard action
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Copy',
                                  style: AppText.body3(
                                    context,
                                    AppColors.referFriendTextColor,
                                  ),
                                ),
                                Space(6.w),
                                Image.asset(AppImage.refferalIcon),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Space(13.h),
                Text(
                  'Do you need a referral code?',
                  style: AppText.body3(
                    context,
                    AppColors.referFriendTextColor2,
                  ),
                ),
                Space(5.h),
                Text(
                  'Redeem code',
                  style: AppText.body3(
                    context,
                    AppColors.darkAppColor,
                  ),
                ),
              ],
            ),

            Space(70.h),
            GestureDetector(
              onTap: () {
                pushNewScreen(
                  context,
                  screen: const ShareToFriendsScreen(),
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 13.0),
                height: 60.h,
                decoration: BoxDecoration(
                    color: AppColors.appColor,
                    borderRadius: BorderRadius.circular(6.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImage.shareIcon),
                    Space(8.w),
                    Text(
                      'Share to friends',
                      style: AppText.body3(
                        context,
                        AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
