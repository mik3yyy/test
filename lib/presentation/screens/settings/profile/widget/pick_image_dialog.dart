import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../components/app text theme/app_text_theme.dart';

class PickImageDialog {
  void pickImage(context, VoidCallback fromCamera, VoidCallback fromPhoto) {
    if (Platform.isAndroid) {
      showDialog<void>(
          barrierColor: Colors.black26,
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 100.w),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.r))),
                content: SizedBox(
                    height: 150.h,
                    width: 20.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Space(10.h),
                        InkWell(
                          onTap: () {
                            fromCamera();

                            // getImage(ImageSource.camera);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, right: 30, left: 30),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5, color: Colors.black)),
                            child: Text('Camera',
                                style:
                                    AppText.body5(context, Colors.blue, 20.sp)),
                          ),
                        ),
                        Space(20.h),
                        InkWell(
                          onTap: () {
                            fromPhoto();
                            // getImage(ImageSource.gallery);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, right: 30, left: 30),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: Colors.grey)),
                            child: Text('Gallery',
                                style:
                                    AppText.body5(context, Colors.blue, 20.sp)),
                          ),
                        )
                      ],
                    )));
          });
    } else {
      ImageSource.gallery;
      // getImage(ImageSource.gallery);
    }
  }
}
