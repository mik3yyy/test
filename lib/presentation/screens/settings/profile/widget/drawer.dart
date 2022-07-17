import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/notification/notification_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/prop_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/faq/faq_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/profile.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/safepay/safepay_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/generic_controller.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class Navigation extends HookConsumerWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.watch(genericController);
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
              comingSoon: false,
              image: AppImage.myProfile,
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
              comingSoon: false,
              image: AppImage.myProp,
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
              comingSoon: false,
              title: 'Notification',
              image: AppImage.myNotification,
              onPressed: () {
                if (controller.notification.isEmpty) {
                  ref.read(genericController.notifier).getNotification();
                  ref
                      .read(genericController.notifier)
                      .withdrawalNotificationRequest();
                  pushNewScreen(
                    context,
                    screen: const NotificationScreen(),
                    pageTransitionAnimation: PageTransitionAnimation.fade,
                  );
                } else {
                  pushNewScreen(
                    context,
                    screen: const NotificationScreen(),
                    pageTransitionAnimation: PageTransitionAnimation.fade,
                  );
                }

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
              comingSoon: false,
              image: AppImage.mySafePay,
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
              comingSoon: true,
              image: AppImage.referAFriend,
              onPressed: () {
                // pushNewScreen(context,
                //     screen: const InviteFriendScreen(),
                //     pageTransitionAnimation: PageTransitionAnimation.fade);
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
              comingSoon: false,
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
              comingSoon: false,
              image: AppImage.logOut,
              onPressed: () {
                // ref
                //     .read(localAuthStateProvider.notifier)
                //     .resetbiometrics(false);

                context.navigate(const SigninScreen());
                PreferenceManager.removeToken();
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
  final bool comingSoon;
  final void Function()? onPressed;
  const DrawerList(
      {Key? key,
      required this.title,
      required this.color,
      required this.comingSoon,
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
          Image.asset(
            image,
            color: color,
            height: 30.h,
            width: 25.w,
          ),
          Space(20.w),
          Text(
            title,
            style: AppText.body2(context, Colors.black, 19.sp),
          ),
          const Spacer(),
          comingSoon
              ? Text(
                  "Coming soon",
                  style: AppText.body2(context, Colors.black, 15.sp),
                )
              : Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 15.sp,
                ),
        ],
      ),
    );
  }
}
