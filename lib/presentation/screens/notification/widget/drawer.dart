import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/safepay/safepay_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.only(left: 23.w, right: 23.w);

    return SizedBox(
      width: 300.w,
      child: Drawer(
        child: Container(
          color: AppColors.appColor.withOpacity(0.6),
          child: Padding(
            padding: padding,
            child: Column(
              children: [
                Space(70.h),
                Text(
                  'williams@gmail.com',
                  style: AppText.body2(context, Colors.white, 20.sp),
                ),
                Space(100.h),
                DrawerList(
                  color: Colors.white,
                  title: 'My Profile',
                  image: AppImage.profile,
                  onPressed: () {},
                ),
                Space(10.h),
                const Divider(
                  color: Colors.white,
                  thickness: 0.4,
                ),
                Space(20.h),
                DrawerList(
                  color: Colors.white,
                  title: 'My Prop',
                  image: AppImage.message,
                  onPressed: () {},
                ),
                Space(10.h),
                const Divider(
                  color: Colors.white,
                  thickness: 0.4,
                ),
                Space(20.h),
                DrawerList(
                  color: Colors.white,
                  title: 'Notification',
                  image: AppImage.notification,
                  onPressed: () {},
                ),
                Space(10.h),
                const Divider(
                  color: Colors.white,
                  thickness: 0.4,
                ),
                Space(20.h),
                DrawerList(
                  color: Colors.white,
                  title: 'Safepay',
                  image: AppImage.safePay,
                  onPressed: () {
                    pushNewScreen(context,
                        screen: SafePayScreen(
                            menuScreenContext: context,
                            onScreenHideButtonPressed: () {},
                            hideStatus: false));
                  },
                ),
                Space(10.h),
                const Divider(
                  color: Colors.white,
                  thickness: 0.4,
                ),
                Space(20.h),
                DrawerList(
                  color: Colors.transparent,
                  title: 'FAQ',
                  image: AppImage.safePay,
                  onPressed: () {},
                ),
                Space(10.h),
                const Divider(
                  color: Colors.white,
                  thickness: 0.4,
                ),
                Space(100.h),
                Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.4, color: Colors.white),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Center(
                    child: Text(
                      'Log out',
                      style: AppText.body2(context, Colors.white, 16.sp),
                    ),
                  ),
                )
              ],
            ),
          ),
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
          Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20.sp,
          ),
          const Spacer(),
          Text(
            title,
            style: AppText.body2(context, Colors.white, 19.sp),
          ),
          Space(20.w),
          SvgPicture.asset(
            image,
            color: color,
            height: 20.h,
            width: 20.w,
          )
        ],
      ),
    );
  }
}
