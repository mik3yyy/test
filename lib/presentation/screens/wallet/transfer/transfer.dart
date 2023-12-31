import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/loading_util/loading_util.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/user_profile/user_profile_db.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/tabs/account_info.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/tabs/make_transfer.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/wallet_transfer_vm.dart.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../components/app text theme/app_text_theme.dart';

class Transfer extends StatefulHookConsumerWidget {
  // final List<Wallet>? wallet;
  const Transfer({
    // required this.wallet,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TransferState();
}

class _TransferState extends ConsumerState<Transfer>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userProfileProvider);
    final saveduser = ref.watch(savedUserProvider);
    final accountNum = ref.watch(userProfileProvider);
    var formatter = NumberFormat("#,##0.00");
    FocusScopeNode currentFocus = FocusScope.of(context);

    ref.listen<RequestState>(transferToWalletProvider, (T, value) {
      if (value is Loading) {
        ScreenView.showLoadingView(context);
      } else {
        ScreenView.hideLoadingView(context);
      }
      if (value is Error) {
        context.loaderOverlay.hide();
      }
    });

    return LoaderOverlay(
      overlayWidget: const Center(
        child: SpinKitWave(
          color: AppColors.appColor,
          size: 50.0,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.appColor,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Column(
                  children: [
                    Space(30.h),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const BackButton(color: Colors.white),
                          Space(15.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              userData.maybeWhen(data: (data) {
                                return Text(
                                  "${data.data.defaultWallet.currencyCode} ${formatter.format(num.tryParse(data.data.defaultWallet.balance ?? "0.0"))} ",
                                  style: AppText.header1(
                                      context, Colors.white, 25.sp),
                                );
                              }, orElse: () {
                                return Text(
                                  "${saveduser.countryCode} ${formatter.format(num.tryParse(saveduser.balance ?? "0.0"))}",
                                  style: AppText.header1(
                                      context, Colors.white, 25.sp),
                                );
                              }),

                              Space(10.h),
                              Text(
                                "Kayndrexsphere Account Number: \n${accountNum.maybeWhen(data: (data) => data.data.user.accountNumber, orElse: () => saveduser.accountNumber ?? "0.0")}",
                                style:
                                    AppText.body2(context, Colors.white, 18.sp),
                              ),

                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Space(40.h),
                  ],
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(45.r)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 30.w, right: 30.w, top: 25.h),
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
                              labelStyle: AppText.body2(
                                  context, AppColors.appColor, 19.sp),
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
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 0.2,
                                    blurRadius: 4,
                                    offset: const Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              tabs: const [
                                Tab(
                                  text: 'Wallet Info',
                                ),
                                Tab(
                                  text: 'Make Transfer',
                                ),
                              ],
                            )),
                      ),
                      SizedBox(height: 30.h),
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          // height: 783.h,
                          // color: Colors.blue,
                          child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: _tabController,
                              children: const [
                                AccounInfoTab(),
                                MakeTransfer()
                              ]),
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
