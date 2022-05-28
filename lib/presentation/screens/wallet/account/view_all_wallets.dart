import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/account/available_wallet.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/aba%5BABA%5D/aba_withdraw.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import '../../../components/app text theme/app_text_theme.dart';
import '../withdrawal/Nuban/nuban.dart';
import '../withdrawal/safe_pay_withdraw/select_beneficiary.dart';
import '../withdrawal/swiftcode/swift_code.dart';
import '../withdrawal/widget/withdrawal_method_widget.dart';

class SelectWalletToCreate extends StatelessWidget {
  const SelectWalletToCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Create Wallet',
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
                    'Select wallet to create',
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
                      method: "Dollar wallet",
                      onPressed: () {
                        pushNewScreen(
                          context, screen: const AvailableWallet(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      }),
                  Space(20.h),
                  WithdrawMethod(
                      method: "Pound wallet",
                      onPressed: () {
                        pushNewScreen(
                          context, screen: const ABAWithdrawal(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      }),
                  Space(20.h),
                  WithdrawMethod(
                      method: "Euro wallet",
                      onPressed: () {
                        pushNewScreen(
                          context, screen: const NubanWithdraw(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      }),
                  Space(20.h),
                  WithdrawMethod(
                      method: "Naira wallet",
                      onPressed: () {
                        pushNewScreen(
                          context, screen: const SwiftCodeView(),
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
