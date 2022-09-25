import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/safe_pay_withdraw/withdraw_from_wallet.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../components/app text theme/app_text_theme.dart';

class SelectBeneficiary extends StatefulHookConsumerWidget {
  const SelectBeneficiary({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectBeneficiaryState();
}

class _SelectBeneficiaryState extends ConsumerState<SelectBeneficiary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        title: Text(
          'Safe Transfer',
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
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Padding(
              padding: EdgeInsets.only(right: 20.w, left: 20.w),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 40.h,
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.appColor.withOpacity(0.1),
                      child: Padding(
                        padding: EdgeInsets.only(right: 210.w),
                        child: Center(
                          child: Text(
                            'Select Beneficiary',
                            style:
                                AppText.body2(context, Colors.black54, 20.sp),
                          ),
                        ),
                      ),
                    ),
                    Space(20.h),
                    Expanded(
                      child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  pushNewScreen(
                                    context,
                                    screen: const WithdrawFromWallet(),
                                    withNavBar:
                                        true, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.fade,
                                  );

                                  // );
                                },
                                child: const SelectBeneficiaryBuild());
                          }),
                    ),
                    CustomButton(
                        buttonText: 'Add New',
                        bgColor: AppColors.appColor,
                        borderColor: AppColors.appColor,
                        textColor: Colors.white,
                        onPressed: () {
                          // pushNewScreen(
                          //   context,
                          //   screen: const ViewAllWallet(),
                          //   withNavBar: true, // OPTIONAL VALUE. True by default.
                          //   pageTransitionAnimation: PageTransitionAnimation.fade,
                          // );
                          // context.navigate(AvailableBalance()

                          // );
                        },
                        buttonWidth: 320),
                    Space(90.h),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectBeneficiaryBuild extends StatelessWidget {
  const SelectBeneficiaryBuild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Space(15.w),
        Row(
          children: [
            Container(
              height: 80.h,
              width: 80.w,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(width: 5, color: Colors.grey.shade300)),
            ),
            Space(20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: AppText.body2Bold(context, Colors.black54, 20.sp),
                ),
                Space(7.h),
                Text(
                  'Acc.No: 334556589',
                  style: AppText.body2(context, Colors.black54, 20.sp),
                ),
              ],
            ),
            const Spacer(),
            Icon(Icons.cancel_outlined, color: Colors.grey.shade400),
          ],
        ),
        Space(15.w),
        const Divider(
          color: Colors.black,
          thickness: 0.4,
        ),
      ],
    );
  }
}
