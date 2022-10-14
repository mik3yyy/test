import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/add-fund-to-wallet/debit_credit_card_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app text theme/app_text_theme.dart';
import 'widget/add_fund_container_widget.dart';

class AddFundsToWalletScreen extends StatefulWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  final String route;
  const AddFundsToWalletScreen({
    Key? key,
    required this.route,
    required this.hideStatus,
    required this.menuScreenContext,
    required this.onScreenHideButtonPressed,
  }) : super(key: key);

  @override
  State<AddFundsToWalletScreen> createState() => _AddFundsToWalletScreenState();
}

class _AddFundsToWalletScreenState extends State<AddFundsToWalletScreen> {
  void onAppleResult(payment) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      appBar: AppBar(
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: widget.route == "HomeScreen"
            ? const BackButton(color: Colors.black)
            : const SizedBox.shrink(),
        title: const AppBarTitle(title: 'Portfolio', color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 40.h,
              width: MediaQuery.of(context).size.width,
              color: AppColors.appColor.withOpacity(0.1),
              child: Center(
                child: Text(
                  'Add funds to your wallet',
                  style: AppText.body2Medium(context, Colors.black54, 20.sp),
                ),
              ),
            ),
            Space(30.h),
            AppFundContainerWidget(
              image: AppImage.debitCardIcon,
              text: 'Credit/Debit Card',
              onTap: () {
                pushNewScreen(
                  context, screen: const DebitCreditCardScreen(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );
              },
            ),
            Space(10.h),

            // Space(10.h),

            if (Platform.isIOS) ...[
              // Center(
              //   child: SizedBox(
              //     width: MediaQuery.of(context).size.width - 50,
              //     child: ApplePayButton(
              //       paymentConfigurationAsset:
              //           'default_payment_profile_apple_pay.json',
              //       paymentItems: _paymentItems,
              //       style: ApplePayButtonStyle.black,
              //       type: ApplePayButtonType.inStore,
              //       height: 50,
              //       onPressed: () {
              //         Navigator.pop(context);
              //       },
              //       margin: const EdgeInsets.only(top: 55.0),
              //       onPaymentResult: onAppleResult,
              //       loadingIndicator: const Center(
              //         child: CircularProgressIndicator.adaptive(),
              //       ),
              //     ),
              //   ),
              // ),
            ] else ...[
              // Center(
              //   child: SizedBox(
              //     width: MediaQuery.of(context).size.width - 50,
              //     height: MediaQuery.of(context).size.width * 0.20,
              //     child: GooglePayButton(
              //       paymentConfigurationAsset: JsonAssets.gpayAsset,
              //       paymentItems: _paymentItems,
              //       style: GooglePayButtonStyle.white,
              //       type: GooglePayButtonType.pay,
              //       margin: const EdgeInsets.only(top: 15.0),
              //       onPaymentResult: (data) {},
              //       loadingIndicator: const Center(
              //         child: CircularProgressIndicator(),
              //       ),
              //     ),
              //   ),
              // ),
            ]

            // AppFundContainerWidget(
            //   image: AppImage.googlePay,
            //   text: 'Google Pay',
            //   onTap: () {},
            // ),
          ],
        ),
      ),
    );
  }
}
