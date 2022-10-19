import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

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
            padding: EdgeInsets.only(left: 25.w, right: 25.w),
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
}
