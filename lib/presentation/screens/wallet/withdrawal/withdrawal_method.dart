import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/Nuban/nuban.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/Nuban/beneficiary_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/shared/route_name.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/generic_controller.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../home/widgets/bottomNav/persistent_tab_view.dart';
import 'widget/withdrawal_method_widget.dart';

class WithdrawalMethodScreen extends StatefulHookConsumerWidget {
  const WithdrawalMethodScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WithdrawalMethodScreenState();
}

class _WithdrawalMethodScreenState
    extends ConsumerState<WithdrawalMethodScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(genericController);
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      appBar: AppBar(
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: const BackButton(color: Colors.black),
        title: const AppBarTitle(title: 'Withdraw', color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 40.h,
              width: MediaQuery.of(context).size.width,
              color: AppColors.appColor.withOpacity(0.1),
              child: Padding(
                padding: EdgeInsets.only(right: 210.w),
                child: Center(
                  child: Text(
                    'Withdrawal methods',
                    style: AppText.body2(context, Colors.black54, 20.sp),
                  ),
                ),
              ),
            ),
            Space(20.h),
            Padding(
              padding: EdgeInsets.only(right: 20.w, left: 20.w),
              child: Column(
                children: [
                  WithdrawMethod(
                      method: "Safe Transfer coming soon",
                      onPressed: () {
                        // pushNewScreen(
                        //   context, screen: const SelectBeneficiary(),
                        //   withNavBar: true, // OPTIONAL VALUE. True by default.
                        //   pageTransitionAnimation: PageTransitionAnimation.fade,
                        // );
                      }),
                  Space(20.h),
                  WithdrawMethod(
                      method: "ACH [ABA] coming soon",
                      onPressed: () {
                        // pushNewScreen(
                        //   context,
                        //   screen: controller.ababeneficiary.isNotEmpty
                        //       ? const BeneficiaryScreen(
                        //           routeName: RouteName.aba)
                        //       : const ABAWithdrawal(),
                        //   withNavBar: true, // OPTIONAL VALUE. True by default.
                        //   pageTransitionAnimation: PageTransitionAnimation.fade,
                        // );
                      }),
                  Space(20.h),
                  WithdrawMethod(
                      method: "NUBAN [Nigeria]",
                      onPressed: () {
                        if (controller.beneficiary.isEmpty) {
                          ref
                              .read(genericController.notifier)
                              .getBeneficiaries();
                          pushNewScreen(
                            context,
                            screen: controller.beneficiary.isNotEmpty
                                ? const BeneficiaryScreen(
                                    routeName: RouteName.nuban)
                                : const NubanWithdraw(),

                            // const NubanWithdraw(),
                            withNavBar:
                                true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                                PageTransitionAnimation.fade,
                          );
                        } else {
                          pushNewScreen(
                            context,
                            screen: controller.beneficiary.isNotEmpty
                                ? const BeneficiaryScreen(
                                    routeName: RouteName.nuban)
                                : const NubanWithdraw(),

                            // const NubanWithdraw(),
                            withNavBar:
                                true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                                PageTransitionAnimation.fade,
                          );
                        }
                      }),
                  Space(20.h),
                  WithdrawMethod(
                      method: "Swift Code [BIC]  coming soon",
                      onPressed: () {
                        return;
                        // pushNewScreen(
                        //   context,
                        //   screen: controller.ibanbeneficiary.isNotEmpty
                        //       ? const BeneficiaryScreen(
                        //           routeName: RouteName.swift)
                        //       : const SwiftCodeView(),
                        //   withNavBar: true, // OPTIONAL VALUE. True by default.
                        //   pageTransitionAnimation: PageTransitionAnimation.fade,
                        // );
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
