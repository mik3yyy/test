import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app text theme/app_text_theme.dart';
import '../src/app_snackbar.dart';

class AppSnackBar {
  static void showSuccessSnackBar(BuildContext context,
      {required String message}) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 4),

      // persistent: false,
      builder: (context, controller) {
        return Flash.bar(
          controller: controller,
          margin: EdgeInsets.all(15.h),
          borderRadius: BorderRadius.circular(6.r),
          backgroundColor: Colors.greenAccent,
          behavior: FlashBehavior.floating,
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
      duration: const Duration(seconds: 4),

      // persistent: false,
      builder: (context, controller) {
        return Flash.bar(
          controller: controller,
          margin: EdgeInsets.all(15.h),
          borderRadius: BorderRadius.circular(6.r),
          backgroundColor: Colors.redAccent,
          behavior: FlashBehavior.floating,
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
      duration: const Duration(seconds: 4),

      // persistent: false,
      builder: (context, controller) {
        return Flash.bar(
          controller: controller,
          borderRadius: BorderRadius.circular(6.r),
          margin: EdgeInsets.all(15.h),
          backgroundColor: Colors.blueAccent,
          behavior: FlashBehavior.floating,
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
}
