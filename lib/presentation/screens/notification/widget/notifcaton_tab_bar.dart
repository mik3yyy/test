import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/notification/widget/all_notification_tab_bar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/notification/widget/request_notification_tab_bar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/generic_controller.dart';

class NotificationTabBar extends StatefulHookConsumerWidget {
  const NotificationTabBar({Key? key}) : super(key: key);

  @override
  _NotificationTabBarState createState() => _NotificationTabBarState();
}

class _NotificationTabBarState extends ConsumerState<NotificationTabBar>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        setState(() {
          switch (_tabController.index) {
            case 0:
              ref
                  .read(genericController.notifier)
                  .selectTab(_tabController.index);
              break;
            case 1:
              ref
                  .read(genericController.notifier)
                  .selectTab(_tabController.index);
            // some code here
          }
        });
      });
  }

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            height: 50.h,
          ),
          Column(
            children: [
              SizedBox(
                // padding: EdgeInsets.only(left: 21.w, right: 18.w),
                height: 50.h,
                width: MediaQuery.of(context).size.width,
                child: TabBar(
                  isScrollable: false,
                  controller: _tabController,
                  labelColor: AppColors.greenColor,
                  labelStyle: AppText.body3(context, AppColors.greenColor),
                  unselectedLabelStyle:
                      AppText.body3(context, AppColors.appColor),
                  unselectedLabelColor: AppColors.appColor,
                  labelPadding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  indicatorColor: AppColors.greenColor,
                  tabs: const [
                    Tab(
                      child: Text("All"),
                    ),
                    Tab(
                      child: Text("Requests"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 23.h),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 500.h,
                // height: 580.h,
                // color: Colors.grey,
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    AllNotificationTabBarView(),
                    RequestNotificationTabBarView(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



// Top Tab Handler
//