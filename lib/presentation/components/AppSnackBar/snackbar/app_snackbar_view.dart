import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';

import '../../app text theme/app_text_theme.dart';
import '../src/app_snackbar.dart';

class AppSnackBar {
  static void showSuccessSnackBar(BuildContext context,
      {required String message}) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 7),

      // persistent: false,
      builder: (context, controller) {
        return Flash.bar(
          controller: controller,
          margin: EdgeInsets.all(15.h),
          borderRadius: BorderRadius.circular(6.r),
          backgroundColor: AppColors.appColor,
          behavior: FlashBehavior.fixed,
          position: FlashPosition.top,
          child: FlashBar(
            // title: Text('Title'),
            content: Text(
              message,
              style: AppText.snackbar(context, Colors.white),
            ),
            showProgressIndicator: false,
            // primaryAction: const Icon(
            //   Icons.error_outlined,
            // ),
          ),
        );
      },
    );
  }

  static void showErrorSnackBar(BuildContext context,
      {required String message}) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 7),
      //persistent: false,
      builder: (context, controller) {
        return Flash.bar(
          controller: controller,
          margin: EdgeInsets.all(15.h),
          borderRadius: BorderRadius.circular(6.r),
          backgroundColor: Colors.redAccent,
          behavior: FlashBehavior.fixed,
          position: FlashPosition.top,
          child: FlashBar(
            // title: Text('Title'),
            content: Text(
              message,
              style: AppText.snackbar(context, Colors.white),
            ),
            showProgressIndicator: false,
            // primaryAction: const Icon(
            //   Icons.error_outlined,
            // ),
          ),
        );
      },
    );
  }

  static void showInfoSnackBar(BuildContext context,
      {required String message}) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 7),

      // persistent: false,
      builder: (context, controller) {
        return Flash.bar(
          controller: controller,
          borderRadius: BorderRadius.circular(6.r),
          margin: EdgeInsets.all(15.h),
          backgroundColor: AppColors.appColor,
          behavior: FlashBehavior.fixed,
          position: FlashPosition.top,
          child: FlashBar(
            // title: Text('Title'),
            content: Text(
              message,
              style: AppText.snackbar(context, Colors.white),
            ),
            showProgressIndicator: false,
            // primaryAction: const Icon(
            //   Icons.error_outlined,
            // ),
          ),
        );
      },
    );
  }

  static void showMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: const Text(
                'Ok',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  static showAppToast(toast.ToastGravity? gravity, {String message = ""}) {
    toast.Fluttertoast.showToast(
        msg: message,
        toastLength: toast.Toast.LENGTH_SHORT,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 16.sp);
  }
}
