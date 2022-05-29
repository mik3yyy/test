import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/custom_paint/custom_paint_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/safepay/fund_wallet.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/safepay/view_virtual_card.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app image/app_image.dart';
import '../../../components/app text theme/app_text_theme.dart';

class SafePayScreen extends StatefulHookConsumerWidget {
  const SafePayScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SafePayScreenState();
}

class _SafePayScreenState extends ConsumerState<SafePayScreen> {
  final toggleNumberProvider = StateProvider<bool>((ref) => true);
  @override
  Widget build(BuildContext context) {
    final toggleNumbers = ref.watch(toggleNumberProvider.state);
    return GenericWidget(
      appbar: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
        child: Column(
          children: [
            Space(20.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
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
                      '\$ 200',
                      style: AppText.header1(context, Colors.white, 25.sp),
                    ),
                    Space(10.h),
                    Text(
                      'Default wallet balance',
                      style: AppText.body2(context, Colors.white, 20.sp),
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
      bgColor: AppColors.whiteColor,
      child: SizedBox(
        height: 750.h,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Space(30.h),
            const SafePayCard(),
            Space(20.h),

            Container(
              padding: EdgeInsets.only(left: 35.w, right: 35.w),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      pushNewScreen(context,
                          screen: const ViewVirtualCard(),
                          pageTransitionAnimation:
                              PageTransitionAnimation.fade);
                    },
                    child: Text(
                      'View',
                      style: AppText.body2Medium(context, Colors.black, 20.sp),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Remove ',
                    style: AppText.body2Medium(context, Colors.black12, 20.sp),
                  ),
                ],
              ),
            ),

            Space(30.h),

            Container(
              height: 60.h,
              color: AppColors.appColor,
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'View Exchange rates',
                    style: AppText.body2Medium(context, Colors.white, 20.sp),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                    size: 30,
                  )
                ],
              ),
            ),
            Space(30.h),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Column(
                children: [
                  Container(
                    height: 90.h,
                    color: AppColors.appColor.withOpacity(0.1),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          color: AppColors.appColor.withOpacity(0.5),
                        ),
                        Space(20.w),
                        Text(
                          'Make use of your virtual cards for payment.\nClick on the card to make easy payment',
                          style: AppText.body2Medium(
                              context, Colors.black54, 17.sp),
                        ),
                      ],
                    ),
                  ),
                  Space(30.h),
                  SizedBox(
                    height: 90.h,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upgrade Free account',
                              style: AppText.body2Bold(
                                  context, Colors.black54, 22.sp),
                            ),
                            Space(10.h),
                            Text(
                              'Upgrade your account to add a\nnew virtual card',
                              style: AppText.body2Medium(
                                  context, Colors.black54, 16.sp),
                            ),
                          ],
                        ),
                        const Spacer(),
                        // Space(20.w),
                        Container(
                          width: 120,
                          height: 40.h,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(30.r)),
                          child: Center(
                            child: Text(
                              'UPGRADE',
                              style: AppText.body2Bold(
                                  context, Colors.white, 15.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

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
            // CustomButton(
            //     buttonText: 'Fund card',
            //     bgColor: AppColors.appColor,
            //     borderColor: AppColors.appColor,
            //     textColor: Colors.white,
            //     onPressed: () {
            //       pushNewScreen(
            //         context,
            //         screen: const FundVirtualCard(),
            //         withNavBar: true, // OPTIONAL VALUE. True by default.
            //         pageTransitionAnimation: PageTransitionAnimation.fade,
            //       );
            //       // context.navigate(AvailableBalance()

            //       // );
            //     },
            //     buttonWidth: 320),
          ],
        ),
      ),
    );
  }
}

class SafePayCard extends StatelessWidget {
  const SafePayCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.r),
      child: Stack(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          Container(
            height: 200,
            width: 330,
            color: Colors.indigo[50],
          ),
          Positioned(
            left: -300,
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: 120,
              width: 120,
              child: CustomPaint(
                  foregroundPainter: CircleBlurPainter(
                      circleWidth: 100,
                      blurSigma: 30.0,
                      color: const Color(0xff2790C3))),
            ),
          ),
          Positioned(
            left: 0,
            right: -300,
            top: -100,
            child: SizedBox(
              height: 220,
              width: 220,
              child: CustomPaint(
                  foregroundPainter: CircleBlurPainter(
                      circleWidth: 100,
                      blurSigma: 40.0,
                      color: AppColors.appColor)),
            ),
          ),
          Positioned(
            left: 60,
            right: 0,
            top: 30,
            child: Text(
              'Virtual Card (Free Card)',
              style: AppText.body2Medium(context, Colors.white, 22.sp),
            ),
          ),
          Positioned(
            left: 15,
            right: 0,
            top: 75,
            child: Text(
              'Janeth Doe',
              style: AppText.body2Medium(context, Colors.white, 20.sp),
            ),
          ),
          Positioned(
            left: 15,
            right: 0,
            top: 100,
            child: Text(
              '2817-9403-1784-5372',
              style: AppText.body2Bold(context, Colors.white, 25.sp),
            ),
          ),
          Positioned(
            left: 15,
            right: 0,
            bottom: 10,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Exp. Date',
                      style: AppText.body2Medium(context, Colors.white, 17.sp),
                    ),
                    Space(7.h),
                    Text(
                      '12-2022',
                      style: AppText.body2Medium(context, Colors.white, 17.sp),
                    ),
                  ],
                ),
                const Space(187),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CVV',
                      style: AppText.body2Medium(context, Colors.white, 17.sp),
                    ),
                    Space(7.h),
                    Text(
                      '***',
                      style: AppText.body2Medium(context, Colors.white, 17.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
