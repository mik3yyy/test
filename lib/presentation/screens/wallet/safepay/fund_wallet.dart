import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_textfield.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/withdrawal_succesful_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app image/app_image.dart';
import '../../../components/app text theme/app_text_theme.dart';
import '../../home/widgets/bottomNav/persistent-tab-view.dart';
import '../widget/wallet_view_widget.dart';

class FundVirtualCard extends StatefulHookConsumerWidget {
  const FundVirtualCard({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WithdrawState();
}

class _WithdrawState extends ConsumerState<FundVirtualCard> {
  final passwordToggleStateProvider = StateProvider<bool>((ref) => true);
  final toggleSelectionProvider = StateProvider<String>((ref) => 'IBAN');

  @override
  Widget build(BuildContext context) {
    final togglePassword = ref.watch(passwordToggleStateProvider.state);

    return Scaffold(
      body: WalletViewWidget(
        appBar: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            children: [
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
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
                        '\$ 2,400.00',
                        style: AppText.header1(context, Colors.white, 25.sp),
                      ),
                      Space(10.h),
                      Text(
                        'Available Balance',
                        style: AppText.body2(context, Colors.white, 16.sp),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                  Space(10.w),
                  const CircleAvatar(
                    radius: 18.0,
                    backgroundImage: AssetImage(
                      AppImage.image1,
                    ),
                  )
                ],
              ),

              // const WalletOptionList()
            ],
          ),
        ),
        child: SizedBox(
          height: 700.h,
          child: Padding(
            padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 20.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Space(30.h),
                  Text(
                    'Enter fund amount',
                    style: AppText.body2(context, AppColors.appColor, 19.sp),
                  ),
                  Space(5.h),
                  const WalletTextField(
                    keyboardType: TextInputType.number,
                    labelText: 'Click to type',
                    obscureText: false,
                    color: Colors.white,
                  ),
                  Space(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.warning_outlined,
                        color: Colors.red,
                        size: 19.sp,
                      ),
                      Space(5.w),
                      Text(
                        'insufficient amount in wallet',
                        style: AppText.body2(context, Colors.red, 19.sp),
                      ),
                    ],
                  ),
                  Space(250.h),
                  Center(
                    child: Text(
                      'Enter password',
                      style:
                          AppText.header3(context, AppColors.appColor, 20.sp),
                    ),
                  ),
                  Space(5.h),
                  Center(
                    child: Text(
                      'For security reasons, please enter your password',
                      style: AppText.body2(context, AppColors.appColor, 18.sp),
                    ),
                  ),
                  Space(5.h),
                  WalletTextField(
                    labelText: '',
                    obscureText: true,
                    color: Colors.white,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        togglePassword.state = !togglePassword.state;
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 0.h),
                        child: Icon(
                          togglePassword.state
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.appColor,
                        ),
                      ),
                    ),
                  ),
                  Space(10.h),
                  CustomButton(
                      buttonText: 'Proceed',
                      bgColor: AppColors.appColor,
                      borderColor: AppColors.appColor,
                      textColor: Colors.white,
                      onPressed: () {
                        pushNewScreen(
                          context,
                          screen: const WalletSuccesScreen(
                              text: 'Transfer Successful',
                              amount: '',
                              availableBalance: '300'),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                        // context.navigate(AvailableBalance()

                        // );
                      },
                      buttonWidth: MediaQuery.of(context).size.width),
                  Space(7.h),
                  Center(
                    child: Text(
                      'Cancel',
                      style:
                          AppText.header3(context, AppColors.appColor, 20.sp),
                    ),
                  ),
                  Space(100.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ToggleSelection extends StatelessWidget {
  final String name;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final void Function()? onPressed;
  const ToggleSelection(
      {Key? key,
      required this.name,
      required this.color,
      required this.borderColor,
      required this.textColor,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      height: 40,
      width: 150,
      decoration: BoxDecoration(
          border: Border.all(width: 1.w, color: borderColor),
          borderRadius: BorderRadius.circular(30.r),
          color: color),
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Text(
            name,
            style: AppText.body2(context, textColor, 19.sp),
          ),
        ),
      ),
    );
  }
}
