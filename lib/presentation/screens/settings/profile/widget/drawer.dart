import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/signin_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/profile_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/device_id.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/sign_out_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/notification/notification_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/prop_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/faq/faq_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/profile.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/safepay/safepay_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../invite friend/invite_friend.dart';

class Navigation extends HookConsumerWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final padding = EdgeInsets.only(left: 30.w, right: 30.w);

    return SizedBox(
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            Space(50.h),
            DrawerList(
              color: Colors.black,
              title: 'My Profile',
              image: AppImage.profile,
              onPressed: () {
                pushNewScreen(context,
                    screen: const MyProfile(),
                    pageTransitionAnimation: PageTransitionAnimation.fade);
              },
            ),
            Space(10.h),
            Divider(
              thickness: 1,
              height: 20.h,
            ),
            Space(30.h),
            DrawerList(
              color: Colors.black,
              title: 'My Prop',
              image: AppImage.prop,
              onPressed: () {
                pushNewScreen(
                  context,
                  screen: const PropScreen(),
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );
              },
            ),
            Space(10.h),
            Divider(
              thickness: 1,
              height: 20.h,
            ),
            Space(30.h),
            DrawerList(
              color: Colors.black,
              title: 'Notification',
              image: AppImage.notification,
              onPressed: () {
                pushNewScreen(
                  context,
                  screen: const NotificationScreen(),
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );
              },
            ),
            Space(10.h),
            Divider(
              thickness: 1,
              height: 20.h,
            ),
            Space(30.h),
            DrawerList(
              color: Colors.black,
              title: 'Safepay',
              image: AppImage.security,
              onPressed: () {
                pushNewScreen(
                  context,
                  screen: const SafePayScreen(),
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );
              },
            ),
            Space(10.h),
            Divider(
              thickness: 1,
              height: 20.h,
            ),
            Space(30.h),
            DrawerList(
              color: Colors.black,
              title: 'Refer a friend',
              image: AppImage.referFriend,
              onPressed: () {
                pushNewScreen(context,
                    screen: const InviteFriendScreen(),
                    pageTransitionAnimation: PageTransitionAnimation.fade);
              },
            ),
            Space(10.h),
            Divider(
              thickness: 1,
              height: 20.h,
            ),
            Space(30.h),
            DrawerList(
              color: Colors.black,
              title: 'FAQ',
              image: AppImage.faq,
              onPressed: () {
                pushNewScreen(context,
                    screen: const FaqScreen(),
                    pageTransitionAnimation: PageTransitionAnimation.fade);
              },
            ),
            Space(10.h),
            Divider(
              thickness: 1,
              height: 20.h,
            ),
            Space(30.h),
            DrawerList(
              color: Colors.black,
              title: 'log out',
              image: AppImage.logout,
              onPressed: () {
                DeviceID.deviceId().then((value) {
                  ref.read(signOutProvider.notifier).signOut(value);
                });
                context.navigate(const SigninScreen());
                PreferenceManager.clear();
              },
            ),
            Space(10.h),
            Divider(
              thickness: 1,
              height: 20.h,
            ),
            Space(100.h),
          ],
        ),
      ),
    );
  }
}

class DrawerList extends StatelessWidget {
  final String title;
  final String image;
  final Color color;
  final void Function()? onPressed;
  const DrawerList(
      {Key? key,
      required this.title,
      required this.color,
      required this.onPressed,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // const hoverColor = Colors.white;
    return InkWell(
      onTap: onPressed,
      // hoverColor: hoverColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            image,
            color: color,
            height: 20.h,
            width: 20.w,
          ),
          Space(20.w),
          Text(
            title,
            style: AppText.body2(context, Colors.black, 19.sp),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 15.sp,
          ),
        ],
      ),
    );
  }
}
