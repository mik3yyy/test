import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/tabs/account_info.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/tabs/make_transfer.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../components/app text theme/app_text_theme.dart';
import 'widget/wallet_view_widget.dart';

class WalletTab extends StatefulWidget {
  const WalletTab({Key? key}) : super(key: key);

  @override
  State<WalletTab> createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  late TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WalletViewWidget(
        appBar: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            children: [
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (() => Navigator.pop(context)),
                    child: const Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.white,
                    ),
                  ),
                  Space(15.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '\$ 2,400.00',
                        style: AppText.header1(context, Colors.white, 25.sp),
                      ),
                      Space(10.h),
                      Text(
                        'Available Balance',
                        style: AppText.body2(context, Colors.white, 16.sp),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                  Space(10.w),
                  const CircleAvatar(
                    radius: 18.0,
                    backgroundImage: AssetImage(
                      AppImage.image1,
                    ),
                  )
                ],
              ),
              Space(30.h),
              // const WalletOptionList()
            ],
          ),
        ),
        child: SizedBox(
          height: 700.h,
          child: Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 15.h),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 0.w, right: 0.w),
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
                      labelPadding: EdgeInsets.zero,
                      indicatorPadding: EdgeInsets.zero,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.r),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 7), // changes position of shadow
                          ),
                        ],
                      ),
                      tabs: const [
                        Tab(
                          text: 'Account Info',
                          //     child: Text(
                          //   'Account Info',
                          //   style:
                          //       AppText.body2(context, AppColors.appColor, 19.sp),
                          // )
                        ),
                        Tab(
                          text: 'Make Transfer',
                          //     child: Text(
                          //   'Make Transfer',
                          //   style:
                          //       AppText.body2(context, AppColors.appColor, 19.sp),
                          // )
                        ),
                      ],
                    )),
                SizedBox(height: 30.h),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 573.h,
                  // color: Colors.grey,
                  child: TabBarView(
                      controller: _tabController,
                      children: const [AccounInfoTab(), MakeTransfer()]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
