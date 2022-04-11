import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';

class NotificationToggle extends StatefulWidget {
  const NotificationToggle({Key? key}) : super(key: key);

  @override
  State<NotificationToggle> createState() => _NotificationToggleState();
}

class _NotificationToggleState extends State<NotificationToggle> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: 50.w,
      height: 30.h,
      borderRadius: 16.r,
      activeColor: AppColors.greenColor,
      inactiveColor: AppColors.notificationColor,
      // toggleColor: const Color(0xFFCFCFD5),
      switchBorder: Border.all(
        color: const Color(0xFFDFDFE3),
        width: 1.0,
      ),
      value: status,
      onToggle: (val) {
        setState(() {
          status = val;
        });
      },
    );
  }
}
