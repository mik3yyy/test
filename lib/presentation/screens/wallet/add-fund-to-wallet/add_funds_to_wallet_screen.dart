import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/add-fund-to-wallet/debit_credit_card_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app text theme/app_text_theme.dart';
import 'widget/add_fund_container_widget.dart';
import 'widget/add_fund_heading_container.dart';

class AddFundsToWalletScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      appBar: route == "HomeScreen"
          ? AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              leading: GestureDetector(
                onTap: (() => Navigator.pop(context)),
                child: const Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.black,
                ),
              ),
            )
          : AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.appBgColor,
              elevation: 0,
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
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );
              },
            ),
            Space(10.h),
            AppFundContainerWidget(
              image: AppImage.debitCardIcon,
              text: 'Pay',
              onTap: () {},
            ),
            Space(10.h),
            AppFundContainerWidget(
              image: AppImage.debitCardIcon,
              text: 'Google Pay',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
