import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/main_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app image/app_image.dart';
import '../../../components/app text theme/app_text_theme.dart';
import '../../../components/reusable_widget.dart/custom_button.dart';
import 'wallet_view_widget.dart';

class WalletSuccesScreen extends StatelessWidget {
  // final BuildContext menuScreenContext;
  // final Function onScreenHideButtonPressed;
  // final bool hideStatus;
  final String text;
  final String amount;
  final String availableBalance;
  const WalletSuccesScreen(
      {Key? key,
      required this.text,
      required this.amount,
      required this.availableBalance

      // required this.menuScreenContext,
      // required this.onScreenHideButtonPressed,
      // required this.hideStatus
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                // InkWell(
                //   onTap: (() => Navigator.pop(context)),
                //   child: const Icon(
                //     Icons.arrow_back_ios_outlined,
                //     color: Colors.white,
                //   ),
                // ),
                Space(15.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '\$ $availableBalance',
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
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 40.h),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Space(30.h),
                        Text(
                          text,
                          style: AppText.header1(
                              context, AppColors.appColor, 30.sp),
                        ),
                        Space(50.h),
                        Text(
                          amount,
                          style: AppText.header3(
                            context,
                            AppColors.appColor,
                            25.sp,
                          ),
                        ),
                      ],
                    ),
                    Space(10.h),
                    Image.asset(AppImage.image4),
                    Space(32.h),
                  ],
                ),
              ),
              Space(25.h),
              CustomButton(
                buttonWidth: MediaQuery.of(context).size.width,
                buttonText: buttonText(context, "Home"),
                bgColor: AppColors.appColor,
                borderColor: AppColors.appColor,
                textColor: Colors.white,
                onPressed: () {
                  context.navigate(MainScreen(menuScreenContext: context));
                },
              ),
              Space(35.h),
            ],
          ),
        ),
      ),
    )

        // SizedBox(
        //   child: CustomWalletAppBarWithChild(
        //     containerOneHeight: 170.h,
        //     containerTwoHeight: 900.h,
        //     containerTwoMargin: 130.h,
        //     child1: Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Padding(
        //               padding: const EdgeInsets.only(top: 10.0),
        //               child: Row(
        //                 // crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                const Icon(
        //                     Icons.chevron_left,
        //                     color: Colors.white,
        //                   ),
        //                   Space(4.h),
        //                   Text(
        //                     'Withdraw money',
        //                     style: AppText.header1(context, Colors.white, 23.sp),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Row(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsets.only(top: 3.0),
        //                   child: Icon(
        //                     Icons.notifications,
        //                     color: Colors.white,
        //                     size: 18.sp,
        //                   ),
        //                 ),
        //                 Space(15.w),
        //                 const CircleAvatar(
        //                   radius: 18.0,
        //                   backgroundImage: AssetImage(
        //                     AppImage.image1,
        //                   ),
        //                 )
        //               ],
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //     child2: Padding(
        //       padding: EdgeInsets.fromLTRB(26.0.w, 33.0.h, 26.0.w, 0.0),
        //       child: Column(
        //         children: [
        //           Container(
        //             width: MediaQuery.of(context).size.width,
        //             decoration: BoxDecoration(
        //                 color: Colors.white,
        //                 borderRadius: BorderRadius.circular(10.r)),
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Column(
        //                   children: [
        //                     Space(30.h),
        //                     Text(
        //                       'Payment successful',
        //                       style: AppText.header1(
        //                           context, AppColors.appColor, 30.sp),
        //                     ),
        //                     Space(50.h),
        //                     Text(
        //                       'N5,000',
        //                       style: AppText.header3(
        //                         context,
        //                         AppColors.appColor,
        //                         25.sp,
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //                 Space(10.h),
        //                 Image.asset(AppImage.image4),
        //                 Space(32.h),
        //               ],
        //             ),
        //           ),
        //           Space(40.h),
        //           CustomButton(
        //             buttonHeight: 98.h,
        //             buttonText: 'Home',
        //             bgColor: AppColors.appColor,
        //             borderColor: AppColors.appColor,
        //             textColor: Colors.white,
        //             onPressed: () {},
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}
