import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/Nuban/nuban.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/Nuban/beneficiary_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/aba%5BABA%5D/aba_withdraw.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/safe_pay_withdraw/select_beneficiary.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/shared/route_name.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/swiftcode/swift_code.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/withdrawal_controller.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../home/widgets/bottomNav/persistent-tab-view.dart';
import 'widget/withdrawal_method_widget.dart';

class WithdrawalMethodScreen extends HookConsumerWidget {
  const WithdrawalMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.watch(withdrawalController);
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Withdrawal',
          style: AppText.header2(context, Colors.black, 20.sp),
        ),
        leading: InkWell(
          onTap: (() => Navigator.pop(context)),
          child: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
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
                      method: "Safe Transfer",
                      onPressed: () {
                        pushNewScreen(
                          context, screen: const SelectBeneficiary(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      }),
                  Space(20.h),
                  WithdrawMethod(
                      method: "ACH [ABA]",
                      onPressed: () {
                        pushNewScreen(
                          context,
                          screen: controller.ababeneficiary.isNotEmpty
                              ? const BeneficiaryScreen(
                                  routeName: RouteName.aba)
                              : const ABAWithdrawal(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      }),
                  Space(20.h),
                  WithdrawMethod(
                      method: "NUBAN [Nigeria]",
                      onPressed: () {
                        pushNewScreen(
                          context,
                          screen: controller.beneficiary.isNotEmpty
                              ? const BeneficiaryScreen(
                                  routeName: RouteName.nuban)
                              : const NubanWithdraw(),

                          // const NubanWithdraw(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      }),
                  Space(20.h),
                  WithdrawMethod(
                      method: "Swift Code [BIC]",
                      onPressed: () {
                        pushNewScreen(
                          context,
                          screen: controller.ibanbeneficiary.isNotEmpty
                              ? const BeneficiaryScreen(
                                  routeName: RouteName.swift)
                              : const SwiftCodeView(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
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
