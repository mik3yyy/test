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
}
