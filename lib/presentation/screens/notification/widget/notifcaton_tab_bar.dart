import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/notification/widget/all_notification_tab_bar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/notification/widget/request_notification_tab_bar_view.dart';

class NotificationTabBar extends StatefulWidget {
  // final String text1;
  // final String text2;
  // final String text3;
  // final List<Widget> children;
  const NotificationTabBar(
      {
      //   required this.text1,
      // required this.text2,
      // required this.text3,
      // required this.children,
      Key? key})
      : super(key: key);

  @override
  _NotificationTabBarState createState() => _NotificationTabBarState();
}

class _NotificationTabBarState extends State<NotificationTabBar>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            // margin: EdgeInsets.only(left: 20.w, right: 20.w),
            height: 50.h,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(5.r),
            //   color: const Color(0xffe8e8e8),
            // ),
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

                  // indicator: BoxDecoration(
                  //   // borderRadius: BorderRadius.circular(6.r),
                  //   color: AppColors.primaryColor,
                  // ),
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
                  children: [
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