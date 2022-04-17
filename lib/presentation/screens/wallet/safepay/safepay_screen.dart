import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/safepay/fund_wallet.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/view_all_wallets.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app image/app_image.dart';
import '../../../components/app text theme/app_text_theme.dart';

class SafePayScreen extends StatefulHookConsumerWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  const SafePayScreen(
      {Key? key,
      required this.menuScreenContext,
      required this.onScreenHideButtonPressed,
      required this.hideStatus})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SafePayScreenState();
}

class _SafePayScreenState extends ConsumerState<SafePayScreen> {
  final passwordToggleStateProvider = StateProvider<bool>((ref) => true);
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
                        '\$ 0',
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
            padding: EdgeInsets.only(left: 23.w, right: 23.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      AppImage.debitCard,
                      height: 230.h,
                      width: 230.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 30.w, right: 30.w, bottom: 30.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 19.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Safe Pay',
                                  style: AppText.body2(
                                      context, Colors.white, 20.sp),
                                ),
                                Space(85.w),
                                InkWell(
                                  onTap: () {
                                    togglePassword.state =
                                        !togglePassword.state;
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Icon(
                                        togglePassword.state
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: AppColors.appColor,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Space(30.h),
                          // Text(
                          //   'dfdkfjdblkjfvbd;fjk;nbfnb;fnb;dogn',
                          //   style: AppText.body2(context, Colors.white, 20.sp),
                          // ),

                          RichText(
                            text: TextSpan(
                              text: '1233  ',
                              style: AppText.debitCard(
                                  context, Colors.white, 20.sp, 5.w),
                              children: togglePassword.state == true
                                  ? <TextSpan>[
                                      TextSpan(
                                        text: '****  ',
                                        style: AppText.debitCard(
                                            context, Colors.white, 20.sp, 5.w),
                                      ),
                                      TextSpan(
                                        text: '****  ',
                                        style: AppText.debitCard(
                                            context, Colors.white, 20.sp, 5.w),
                                      ),
                                      TextSpan(
                                        text: '****',
                                        style: AppText.debitCard(
                                            context, Colors.white, 20.sp, 5.w),
                                      ),
                                    ]
                                  : <TextSpan>[
                                      TextSpan(
                                        text: '2343  ',
                                        style: AppText.debitCard(
                                            context, Colors.white, 20.sp, 5.w),
                                      ),
                                      TextSpan(
                                        text: '4453  ',
                                        style: AppText.debitCard(
                                            context, Colors.white, 20.sp, 5.w),
                                      ),
                                      TextSpan(
                                        text: '3424',
                                        style: AppText.debitCard(
                                            context, Colors.white, 20.sp, 5.w),
                                      ),
                                    ],
                            ),
                          ),
                          Space(50.h),
                          Container(
                            padding: EdgeInsets.only(left: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '25\\34',
                                  style: AppText.header2(
                                      context, Colors.white, 20.sp),
                                ),
                                Space(200.w),
                                Text(
                                  '345',
                                  style: AppText.header2(
                                      context, Colors.white, 20.sp),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Space(30.h),
                //!!!!!
                //!!!!!
                //!!!!! change to successful when payment is successful

                //  const Image(
                //     image: AssetImage(
                //   AppImage.successSafepay,
                // )),
                //!!!!!
                //!!!!!
                //!!!!!
                //!!!!!
                //!!!!! change to insufficient when payment is insufficent

                //  const Image(
                //     image: AssetImage(
                //   AppImage.insufficient,
                // )),
                //!!!!!
                //!!!!!
                const Image(
                    image: AssetImage(
                  AppImage.safePayIcon,
                )),
                Space(30.h),
                Container(
                  margin: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Text(
                    'You can fund your virtual card from any of your wallets',
                    textAlign: TextAlign.center,
                    style: AppText.header2(context, AppColors.appColor, 20.sp),
                  ),
                ),
                //!!!!!
                //!!!!!
                //!!!!! This is for scanning POS Machine
                //!!!!!
                //!!!!!
                //  Container(
                //   margin: EdgeInsets.only(left: 20.w, right: 20.w),
                //   child: Text(
                //     'Scan POS machine using NFC for quick pay',
                //     textAlign: TextAlign.center,
                //     style: AppText.header2(context, AppColors.appColor, 20.sp),
                //   ),
                // ),
                Space(55.h),
                CustomButton(
                    buttonText: 'Fund card',
                    bgColor: AppColors.appColor,
                    borderColor: AppColors.appColor,
                    textColor: Colors.white,
                    onPressed: () {
                      pushNewScreen(
                        context,
                        screen: const FundVirtualCard(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                      // context.navigate(AvailableBalance()

                      // );
                    },
                    buttonWidth: 320),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
