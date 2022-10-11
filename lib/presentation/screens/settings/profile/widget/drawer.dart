import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/notification/notification_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/prop_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/faq/faq_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/profile.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/state_of_acct/statement_of_acct.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

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
              comingSoon: false,
              isIcon: false,
              image: AppImage.myProfile,
              onPressed: () {
                pushNewScreen(context,
                    withNavBar: true,
                    screen: const MyProfile(),
                    pageTransitionAnimation: PageTransitionAnimation.cupertino);
              },
            ),
            const Divider(
              thickness: 1,
            ),
            DrawerList(
              color: Colors.black,
              title: 'My Prop',
              comingSoon: false,
              isIcon: false,
              image: AppImage.myProp,
              onPressed: () {
                // context.navigate(const PropScreen());
                pushNewScreen(
                  context,
                  withNavBar: true,
                  screen: const PropScreen(),
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
            ),
            const Divider(
              thickness: 1,
            ),
            DrawerList(
              color: Colors.black,
              comingSoon: false,
              isIcon: false,
              title: 'Notification',
              image: AppImage.myNotification,
              onPressed: () {
                ///CHECK IF AUTODISPOSE WORKS

                pushNewScreen(
                  context,
                  withNavBar: false,
                  screen: const NotificationScreen(),
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
            ),
            const Divider(
              thickness: 1,
            ),
            DrawerList(
              color: Colors.black,
              title: 'Safepay',
              comingSoon: true,
              isIcon: false,
              image: AppImage.mySafePay,
              onPressed: () {
                // pushNewScreen(
                //   context,
                //   screen: const SafePayScreen(),
                //   pageTransitionAnimation: PageTransitionAnimation.fade,
                // );
              },
            ),
            const Divider(
              thickness: 1,
            ),
            DrawerList(
              color: Colors.black,
              title: 'Statement of account',
              comingSoon: false,
              isIcon: false,
              image: AppImage.document,
              onPressed: () {
                pushNewScreen(context,
                    screen: const StatementOfAcctScreen(),
                    pageTransitionAnimation: PageTransitionAnimation.fade);
              },
            ),
            const Divider(
              thickness: 1,
            ),
            DrawerList(
              color: Colors.black,
              title: 'Refer a friend',
              comingSoon: true,
              isIcon: false,
              image: AppImage.referAFriend,
              onPressed: () {
                // pushNewScreen(context,
                //     screen: const InviteFriendScreen(),
                //     pageTransitionAnimation: PageTransitionAnimation.fade);
              },
            ),
            const Divider(
              thickness: 1,
            ),
            DrawerList(
              color: Colors.black,
              comingSoon: false,
              title: 'FAQ',
              image: "assets/images/new_faq.png",
              isIcon: true,
              onPressed: () {
                // context.navigate(const FaqScreen());
                pushNewScreen(context,
                    withNavBar: false,
                    screen: const FaqScreen(),
                    pageTransitionAnimation: PageTransitionAnimation.cupertino);
              },
            ),
            const Divider(
              thickness: 1,
            ),
            DrawerList(
              color: Colors.black,
              title: 'log out',
              comingSoon: false,
              isIcon: false,
              image: AppImage.logOut,
              onPressed: () {
                // ref
                //     .read(localAuthStateProvider.notifier)
                //     .resetbiometrics(false);
                PreferenceManager.clear();
                context.navigateReplaceRoot(const SigninScreen());
              },
            ),
            Space(10.h),
            const Divider(
              thickness: 1,
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
  final bool isIcon;
  final void Function()? onPressed;
  const DrawerList(
      {Key? key,
      required this.title,
      required this.isIcon,
      required this.color,
      required this.comingSoon,
      required this.onPressed,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const hoverColor = Colors.red;
    return InkWell(
      onTap: onPressed,
      hoverColor: hoverColor,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.062,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              isIcon
                  ? const Icon(
                      Icons.help,
                      size: 20,
                      color: Colors.black,
                    )
                  : Image.asset(
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
        ),
      ),
    );
  }
}
