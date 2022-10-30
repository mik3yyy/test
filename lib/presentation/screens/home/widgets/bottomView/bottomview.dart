import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/profile_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/route_state.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomView/transaction_list.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/top_buttons.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/transactions/view_all_transaction_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/transfer/transfer.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/currency_transactions_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/withdrawal_method.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import '../../../../components/app text theme/app_text_theme.dart';

class BottomView extends HookConsumerWidget {
  final AsyncValue<ProfileRes> defaultWallet;
  const BottomView({Key? key, required this.defaultWallet}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(45.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 10, top: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(45.r)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TopButtons(
                              title: 'Transfer',
                              image: AppImage.transfer,
                              firstColor: AppColors.appColor.withOpacity(0.65),
                              secondColor: AppColors.appColor,
                              onPressed: () {
                                ref
                                        .watch(defaultTransactionStateProvider
                                            .notifier)
                                        .state =
                                    defaultWallet
                                        .value!.data.defaultWallet.currencyCode
                                        .toString();
                                pushNewScreen(
                                  context,
                                  screen: const Transfer(),
                                  withNavBar:
                                      false, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              },
                            ),
                            TopButtons(
                              title: 'Add funds',
                              image: AppImage.addFunds,
                              firstColor:
                                  const Color(0xff00848C).withOpacity(0.6),
                              secondColor: const Color(0xff00404E),
                              onPressed: () {
                                ref.watch(routeStateProvider.notifier).index =
                                    2;

                                // print(ref.watch(routeStateProvider).index);
                              },
                            ),
                            TopButtons(
                              title: 'Withdraw',
                              image: AppImage.withdraw,
                              firstColor:
                                  const Color(0xff1E6342).withOpacity(0.6),
                              secondColor: const Color(0xff00351C),
                              onPressed: () {
                                pushNewScreen(
                                  context,
                                  screen: const WithdrawalMethodScreen(),
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              },
                            ),
                          ],
                        ),
                        const Space(20),
                        SizedBox(
                          width: 370.w,
                          child: Row(
                            children: [
                              Text(
                                'Transactions',
                                style: AppText.body2(
                                    context, Colors.black45, 18.sp),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  // context
                                  //     .navigate(const ViewAllTransactionScreen());
                                  pushNewScreen(
                                    context,
                                    screen: const ViewAllTransactionScreen(),
                                    withNavBar:
                                        false, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                                child: Text(
                                  'View all',
                                  style: AppText.body2(
                                      context, AppColors.appColor, 18.sp),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Space(30.h),
                  const DashBoardTransactionList()
                  // Space(10.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
