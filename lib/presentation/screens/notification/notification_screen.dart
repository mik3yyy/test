import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/notification/viewmodel/get_notification_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/notification/viewmodel/request_withdrawal_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/notification/widget/notifcaton_tab_bar.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/generic_controller.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class NotificationScreen extends HookConsumerWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final tab = ref.watch(genericController);

    return Scaffold(
      backgroundColor: AppColors.appColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: (() => Navigator.pop(context)),
                    child: const Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.white,
                    ),
                  ),
                  const Space(100),
                  Text(
                    'Notifications',
                    style: AppText.body2(context, Colors.white, 20.sp),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(45.r)),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 30.h),
                child: Column(
                  children: [
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
                          ref
                              .read(allnotificationSearchQueryProvider.notifier)
                              .state = value;
                        } else {
                          ref
                              .read(notificationReqSearchQueryProvider.notifier)
                              .state = value;
                        }
                      },
                    ),
                    Space(15.h),
                    const NotificationTabBar(),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
