import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app image/app_image.dart';
import '../../../components/app text theme/app_text_theme.dart';
import '../../../components/reusable_widget.dart/custom_button.dart';
import '../widget/wallet_view_widget.dart';

class WithdrawalSuccessfulScreen extends StatelessWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  const WithdrawalSuccessfulScreen(
      {Key? key,
      required this.menuScreenContext,
      required this.onScreenHideButtonPressed,
      required this.hideStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WalletViewWidget(
      appBar: Row(
        children: [
          InkWell(
            onTap: (() => Navigator.pop(context)),
            child: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            ),
          ),
          Space(4.h),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Withdraw money',
                style: AppText.header1(context, Colors.white, 23.sp),
              ),
              // Text(
              //   '',
              //   style: AppText.header1(context, Colors.white, 23.sp),
              // ),
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
      child: Padding(
        padding: const EdgeInsets.all(20),
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
                    offset: Offset(0, 3), // changes position of shadow
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
                        'Payment successful',
                        style:
                            AppText.header1(context, AppColors.appColor, 30.sp),
                      ),
                      Space(50.h),
                      Text(
                        'N5,000',
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
              buttonText: 'Home',
              bgColor: AppColors.appColor,
              borderColor: AppColors.appColor,
              textColor: Colors.white,
              onPressed: () {},
            ),
            Space(35.h),
          ],
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
