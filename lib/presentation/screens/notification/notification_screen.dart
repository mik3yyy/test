import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/notification/notification_setting_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/notification/widget/notifcaton_tab_bar.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/generic_controller.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class NotificationScreen extends HookConsumerWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final tab = ref.watch(genericController);

    return GenericWidget(
      appbar: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          children: [Space(70.h)],
        ),
      ),
      bgColor: AppColors.whiteColor,
      child: Padding(
        padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 15.h),
        child: SizedBox(
          height: 850.h,
          child: Column(
            children: [
              Space(25.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (() => Navigator.pop(context)),
                    child: const Icon(
                      Icons.arrow_back_ios_outlined,
                      color: AppColors.appColor,
                    ),
                  ),
                  Text(
                    'Notifications',
                    style: AppText.body2(context, AppColors.appColor, 20.sp),
                  ),
                  GestureDetector(
                    onTap: () {
                      pushNewScreen(
                        context,
                        screen: const NotificationSettingScreen(),
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                    },
                    child: Image.asset(AppImage.notificationSettingIcon),
                  ),
                ],
              ),
              Space(35.h),
              TextFormField(
                // controller: controller,
                decoration: InputDecoration(
                  hintText: 'Search Notification',
                  // fillColor: AppColors.whiteColor,
                  prefixIcon: const Icon(Icons.search),
                  hintStyle: AppText.body3(
                    context,
                    AppColors.faqHintTextColor,
                  ),
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
                onChanged: (value) {
                  if (tab.tabState == 0) {
                    ref.read(genericController.notifier).filteredNots(value);
                  } else {
                    ref
                        .read(genericController.notifier)
                        .filteredWithdrawalReq(value);
                  }
                },
              ),
              Space(15.h),
              const NotificationTabBar(),
            ],
          ),
        ),
      ),
    );
  }
}
