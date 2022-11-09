import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/profile_image/profile_image.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../components/app image/app_image.dart';
import '../../../../components/app text theme/app_text_theme.dart';

class AppDialog {
  static void showSuccessWalletDialog(
      BuildContext context, String amount, String name) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(left: 25.w, right: 25.w),
            child: CupertinoActionSheet(
              actions: <Widget>[
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Space(30.h),
                      const Icon(
                        Icons.check_circle_outline,
                        color: Colors.greenAccent,
                        size: 100,
                      ),
                      Space(20.h),
                      Text(
                        'Transfer Successful',
                        style: AppText.body2(context, Colors.black, 24.sp),
                      ),
                      Space(30.h),
                      Text(
                        amount,
                        style: AppText.body2(context, Colors.black, 28.sp),
                      ),
                      Space(40.h),
                      Text(
                        name,
                        style: AppText.body2(context, Colors.black, 20.sp),
                      ),
                      Space(40.h),
                    ],
                  ),
                )
              ],
              cancelButton: CupertinoActionSheetAction(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
        });
  }

  static void showSuccessMessageDialog(BuildContext context, String message,
      {required VoidCallback onpressed}) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(left: 25.w, right: 25.w),
            child: CupertinoActionSheet(
              actions: <Widget>[
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Space(30.h),
                      const Icon(
                        Icons.check_circle_outline_rounded,
                        color: Colors.greenAccent,
                        size: 70,
                      ),
                      Space(20.h),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Center(
                          child: Text(
                            message,
                            style: AppText.body2(context, Colors.black, 17.sp),
                          ),
                        ),
                      ),
                      Space(40.h),
                    ],
                  ),
                )
              ],
              cancelButton: CupertinoActionSheetAction(
                child: const Text("Close"),
                onPressed: onpressed,
              ),
            ),
          );
        });
  }

  static void showDetailsDialog(
    BuildContext context, {
    required String transactionType,
    required String amount,
    required String reference,
    required String status,
    required String date,
  }) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: CupertinoActionSheet(
              actions: <Widget>[
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(left: 30.w, right: 5.w, top: 30.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/splashLogo.jpeg",
                            scale: 20,
                          ),
                        ),
                        Center(
                          child: Text(
                            "Transaction Detail",
                            style:
                                AppText.body2Bold(context, Colors.black, 20.sp),
                          ),
                        ),
                        Space(40.h),
                        Text(
                          "Transaction type : $transactionType",
                          style: AppText.body2(context, Colors.black, 18.sp),
                        ),
                        Space(25.h),
                        Text(
                          "Amount : $amount",
                          style: AppText.body2(context, Colors.black, 18.sp),
                        ),
                        if (status.isEmpty) ...[
                          const SizedBox.shrink()
                        ] else ...[
                          Space(25.h),
                          Text(
                            "Status : $status",
                            style: AppText.body2(context, Colors.black, 18.sp),
                          ),
                        ],
                        Space(25.h),
                        Text(
                          "Reference : $reference",
                          style: AppText.body2(context, Colors.black, 18.sp),
                        ),
                        Space(20.h),
                        Text(
                          "Date : $date",
                          style: AppText.body2(context, Colors.black, 18.sp),
                        ),
                        Space(40.h),
                      ],
                    ),
                  ),
                )
              ],
              cancelButton: CupertinoActionSheetAction(
                child: const Text("Close"),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          );
        });
  }

  static void showErrorMessageDialog(BuildContext context, String message) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            child: CupertinoActionSheet(
              actions: <Widget>[
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Space(30.h),
                      const Icon(
                        Icons.cancel_outlined,
                        color: Colors.red,
                        size: 100,
                      ),
                      Space(20.h),
                      // Text(
                      //   'Transfer Successful',
                      //   style: AppText.body2(context, Colors.black, 24.sp),
                      // ),

                      Space(20.h),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Center(
                          child: Text(
                            message,
                            style: AppText.body2(context, Colors.black, 20.sp),
                          ),
                        ),
                      ),
                      Space(40.h),
                    ],
                  ),
                )
              ],
              cancelButton: CupertinoActionSheetAction(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
        });
  }

  static void viewIdOptions(BuildContext context,
      {required VoidCallback deletedID,
      required VoidCallback viewId,
      required VoidCallback editID}) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(left: 25.w, right: 25.w),
            child: CupertinoActionSheet(
              actions: [
                //WalletName
                Container(
                  color: Colors.white,
                  child: CupertinoActionSheetAction(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      child: Text(
                        'View ID',
                        style: AppText.body2(
                          context,
                          AppColors.appColor,
                          18.sp,
                        ),
                      ),
                    ),
                    isDefaultAction: true,
                    onPressed: viewId,
                  ),
                ),
                //View Wallet
                Container(
                  color: Colors.white,
                  child: CupertinoActionSheetAction(
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.w, right: 30.w),
                        child: Text(
                          'Edit ID',
                          style: AppText.body2(
                            context,
                            AppColors.appColor,
                            18.sp,
                          ),
                        ),
                      ),
                      isDefaultAction: true,
                      onPressed: editID),
                ),

                Container(
                  color: Colors.white,
                  child: CupertinoActionSheetAction(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      child: Text(
                        'Delete ID',
                        style: AppText.body2(
                          context,
                          Colors.red,
                          16.sp,
                        ),
                      ),
                    ),
                    isDefaultAction: true,
                    onPressed: deletedID,
                  ),
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                child: Text(
                  "Close",
                  style: AppText.body2(
                    context,
                    AppColors.appColor,
                    18.sp,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
        });
  }

  static void viewId(BuildContext context,
      {required String idNo, required String idType, required String image}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.70,
            child: Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Space(40),
                  Text("ID Type:",
                      style: AppText.body2(context, Colors.black45, 15.sp)),
                  Text(idType,
                      style: AppText.body2(context, Colors.black, 25.sp)),
                  const Space(30),
                  Center(
                    child: Transform.scale(
                      scale: 1.2,
                      child: SizedBox(
                        height: 200,
                        child: KYNetworkImage(
                            url: image,
                            errorImage: Image.asset(AppImage.profile,
                                scale: 5, fit: BoxFit.contain),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  const Space(30),
                  Text("ID number:",
                      style: AppText.body2(context, Colors.black45, 15.sp)),
                  Text(idNo,
                      style: AppText.body2(context, Colors.black, 25.sp)),
                ],
              ),
            ),
          );
        });
  }
}
