import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/notification/widget/notification_toggle.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class NotificationSettingScreen extends StatelessWidget {
  const NotificationSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WalletViewWidget(
        appBar: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [],
              ),
            ],
          ),
        ),
        child: Container(
          height: 850.h,
          padding:
              EdgeInsets.only(left: 25.w, right: 25.w, top: 15.w, bottom: 20.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.chevron_left,
                    color: AppColors.appColor,
                  ),
                  Text(
                    'Notifications',
                    style: AppText.body3(
                      context,
                      AppColors.appColor,
                    ),
                  ),
                  const Space(0),
                ],
              ),
              Space(27.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Notification tone",
                    style: AppText.body3(
                      context,
                      AppColors.appColor,
                    ),
                  ),
                  const NotificationToggle()
                ],
              ),
              Space(24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Vibrate",
                    style: AppText.body3(
                      context,
                      AppColors.appColor,
                    ),
                  ),
                  const NotificationToggle()
                ],
              ),
              Space(24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hide pip Notification",
                    style: AppText.body3(
                      context,
                      AppColors.appColor,
                    ),
                  ),
                  const NotificationToggle()
                ],
              ),
              Space(24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Use high priority notification",
                    style: AppText.body3(
                      context,
                      AppColors.appColor,
                    ),
                  ),
                  const NotificationToggle()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
