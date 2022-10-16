import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/tabs/to_friends_tab.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/tabs/to_wallet_tab.dart';

import '../../../components/app text theme/app_text_theme.dart';

class MakeTransfer extends StatefulHookConsumerWidget {
  const MakeTransfer({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MakeTransferState();
}

class _MakeTransferState extends ConsumerState<MakeTransfer>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  late TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: SizedBox(
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
            ),
            SizedBox(height: 30.h),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 564.h,
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: const [FriendsTab(), ToWallet()]),
            )
          ],
        ),
      ),
    );
  }
}
