import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/sign_in_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/profile/vm/get_user_profile.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/tabs/account_info.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/tabs/make_transfer.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import '../../../components/app text theme/app_text_theme.dart';
import '../widget/wallet_view_widget.dart';

class Transfer extends StatefulHookConsumerWidget {
  // final List<Wallet>? wallet;
  const Transfer(
      {
      // required this.wallet,
      Key? key})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TransferState();
}

class _TransferState extends ConsumerState<Transfer>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // ref.refresh(provider)
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  late TabController _tabController;
  @override
  @override
  Widget build(BuildContext context) {
    final defaultWallet = ref.watch(getUserProfileProvider);
    final accountNo = ref.watch(signInProvider);
    var formatter = NumberFormat('###,000');

    return GenericWidget(
        appbar: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
          child: Column(
            children: [
              Space(20.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
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
                        defaultWallet.maybeWhen(
                            success: (v) =>
                                "${v!.data.defaultWallet.currencyCode!} ${formatter.format(v.data.defaultWallet.balance)} ",
                            orElse: () => ''),
                        style: AppText.header1(context, Colors.white, 25.sp),
                      ),
                      Space(10.h),
                      Text(
                        defaultWallet.maybeWhen(
                            success: (v) =>
                                "Acc No: ${accountNo.maybeMap(success: (v) => v.value!.data!.user!.accountNumber, orElse: () => '')}",
                            orElse: () => ''),
                        style: AppText.body2(context, Colors.white, 16.sp),
                      ),
                      // Text(
                      //   'Available Balance',
                      //   style: AppText.body2(context, Colors.white, 16.sp),
                      // ),
                    ],
                  ),
                ],
              ),
              Space(50.h),
              // const WalletOptionList()
            ],
          ),
        ),
        bgColor: AppColors.whiteColor,
        child: SizedBox(
          height: 770.h,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 25.h),
                  child: Container(
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
                ),
                SizedBox(height: 30.h),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 583.h,
                      // color: Colors.grey,
                      child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children: const [AccounInfoTab(), MakeTransfer()]),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
