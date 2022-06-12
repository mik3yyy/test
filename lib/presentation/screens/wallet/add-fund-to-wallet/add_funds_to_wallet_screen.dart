import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/add-fund-to-wallet/debit_credit_card_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import 'widget/add_fund_container_widget.dart';
import 'widget/add_fund_heading_container.dart';

class AddFundsToWalletScreen extends StatelessWidget {
  const AddFundsToWalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: (() => Navigator.pop(context)),
          child: Icon(
            Icons.chevron_left,
            color: AppColors.textColor,
            size: 60.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const AddFundHeadingContainer(
              text: 'Add funds to your wallet',
              textAlign: TextAlign.center,
              paddingLeft: 0.0,
            ),
            Space(27.h),
            AppFundContainerWidget(
              image: AppImage.debitCardIcon,
              text: 'Credit/Debit Card',
              onTap: () {
                pushNewScreen(
                  context, screen: const DebitCreditCardScreen(),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );
              },
            ),
            Space(10.h),
            AppFundContainerWidget(
              //TODO: To get image later, they are grouped together in the figma file
              image: AppImage.debitCardIcon,
              text: 'Pay',
              onTap: () {
                //TODO: To implement pay method
              },
            ),
            Space(10.h),
            AppFundContainerWidget(
              //TODO: To get image later, they are grouped together in the figma file
              image: AppImage.debitCardIcon,
              text: 'Google Pay',
              onTap: () {
                //TODO: To implement Google Pay method
              },
            ),
          ],
        ),
      ),
    );
  }
}
