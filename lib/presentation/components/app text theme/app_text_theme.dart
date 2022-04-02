import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppText {
  static TextStyle header1(BuildContext context, Color color) {
    return Theme.of(context).textTheme.headline1!.copyWith(
        fontSize: 17.5.sp,
        fontWeight: FontWeight.w400,
        fontFamily: 'Avenir LTStd',
        color: color);
  }

  static TextStyle header2(BuildContext context, Color color) {
    return Theme.of(context).textTheme.headline1!.copyWith(
        fontSize: 17.5.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'Avenir LTStd',
        color: color);
  }

  static TextStyle body1(BuildContext context, Color color) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
        fontSize: 25.0.sp,
        fontWeight: FontWeight.w400,
        fontFamily: 'Avenir LTStd',
        color: color);
  }

  static TextStyle body2(BuildContext context, Color color) {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
        fontSize: 14.5.sp,
        fontWeight: FontWeight.w400,
        fontFamily: 'Avenir LTStd',
        color: color);
  }

  static TextStyle body3(BuildContext context, Color color) {
    return Theme.of(context).textTheme.bodyText2!.copyWith(
        fontSize: 16.5.sp,
        fontWeight: FontWeight.w400,
        fontFamily: 'Avenir LTStd',
        color: color);
  }

  static TextStyle label(BuildContext context, Color color) {
    return Theme.of(context).textTheme.labelSmall!.copyWith(
        fontSize: 12.5.sp,
        fontWeight: FontWeight.w400,
        fontFamily: 'Avenir LTStd',
        color: color);
  }

  static TextStyle snackbar(BuildContext context, Color color) {
    return Theme.of(context).textTheme.labelSmall!.copyWith(
        fontSize: 14.5.sp,
        fontWeight: FontWeight.w400,
        fontFamily: 'Avenir LTStd',
        color: color);
  }
}
