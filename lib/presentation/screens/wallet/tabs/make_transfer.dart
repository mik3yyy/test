import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/tabs/to_friends_tab.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/tabs/to_wallet_tab.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app text theme/app_text_theme.dart';

class MakeTransfer extends StatefulWidget {
  const MakeTransfer({Key? key}) : super(key: key);

  @override
  State<MakeTransfer> createState() => _MakeTransferState();
}

class _MakeTransferState extends State<MakeTransfer>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  late TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Container(
              height: 50.h,
              width: 165.w,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.w),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25.r)),
            ),
            Space(30.2.w),
            Container(
              height: 50.h,
              width: 165.w,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.w),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25.r)),
            ),
          ],
        ),
        SizedBox(
          child: Column(
            children: [
              Container(
                  height: 50.h,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.black,
                  child: TabBar(
                    isScrollable: false,
                    controller: _tabController,
                    // unselectedLabelColor: Colors.white,

                    labelColor: AppColors.appColor,
                    labelStyle:
                        AppText.body2(context, AppColors.appColor, 19.sp),
                    unselectedLabelStyle:
                        AppText.body2(context, Colors.black45, 19.sp),
                    unselectedLabelColor: Colors.black26,
                    labelPadding: EdgeInsets.only(right: 13.w),
                    indicatorPadding: EdgeInsets.zero,
                    indicator: BoxDecoration(
                      border:
                          Border.all(color: AppColors.appColor, width: 0.5.w),
                      borderRadius: BorderRadius.circular(25.r),
                      color: Colors.grey[200],
                    ),
                    tabs: const [
                      Tab(
                        text: 'To friend',
                      ),
                      Tab(
                        text: 'To wallet',
                      ),
                    ],
                  )),
              SizedBox(height: 30.h),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 484.h,
                // color: Colors.grey,
                child: TabBarView(
                    controller: _tabController,
                    children: [FriendsTab(), const ToWallet()]),
              )
            ],
          ),
        ),
      ],
    );
  }
}
