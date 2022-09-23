import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/state_of_acct/tabs/credit_tab.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/state_of_acct/tabs/debit_tab.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/state_of_acct/tabs/view_all.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/swiftcode/search_box.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../components/app text theme/app_text_theme.dart';

class EWalletAccountHistory extends StatefulHookConsumerWidget {
  const EWalletAccountHistory({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EWalletAccountHistoryState();
}

class _EWalletAccountHistoryState extends ConsumerState<EWalletAccountHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // ref.refresh(provider)
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'E-Wallet Account History',
          style: AppText.header2(context, Colors.black, 20.sp),
        ),
        leading: InkWell(
          onTap: (() => Navigator.pop(context)),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 23, right: 23),
          child: Column(
            children: [
              const Space(20),
              SearchBox(
                hintText: "Search date (dd/mm/yyyy)",
                onTextEntered: (value) {
                  // ref.read(currencySearchQueryStateProvider.notifier).state =
                  //     value;
                },
              ),
              const Space(30),
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    margin: EdgeInsets.only(left: 9.w, right: 9.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28.r),
                        color: Colors.grey.shade300),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 2.h),
                    child: Container(
                        padding: EdgeInsets.only(left: 0.w, right: 0.w),
                        height: 50.h,
                        width: MediaQuery.of(context).size.width,
                        // color: Colors.black,
                        child: TabBar(
                          isScrollable: false,
                          controller: _tabController,
                          // unselectedLabelColor: Colors.white,

                          labelColor: Colors.white,
                          labelStyle:
                              AppText.body2(context, AppColors.appColor, 19.sp),
                          unselectedLabelStyle:
                              AppText.body2(context, Colors.black45, 19.sp),
                          unselectedLabelColor: Colors.black26,
                          labelPadding: EdgeInsets.zero,
                          indicatorPadding: EdgeInsets.zero,

                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            color: AppColors.appColor,
                          ),
                          tabs: const [
                            Tab(
                              text: 'View all',
                            ),
                            Tab(
                              text: 'Credit',
                            ),
                            Tab(
                              text: 'Debit',
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  // height: 783.h,
                  // color: Colors.blue,
                  child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: const [
                        ViewAllStatement(),
                        CreditTabView(),
                        DebitTabView()
                      ]),
                ),
              ),
              SizedBox(height: 80.h),
            ],
          ),
        ),
      ),
    );
  }
}
