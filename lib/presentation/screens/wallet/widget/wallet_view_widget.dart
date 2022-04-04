import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class WalletViewWidget extends StatelessWidget {
  final Widget appBar;
  final Widget child;
  const WalletViewWidget({Key? key, required this.appBar, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 900.h,
          color: AppColors.appColor,
          child: Column(
            children: [
              Space(55.h),
              appBar,
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
              decoration: BoxDecoration(
                color: AppColors.bottomSheet,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
              ),
              // height: 540,
              width: 33.w,
              child: child),
        ),
      ],
    );
  }
}