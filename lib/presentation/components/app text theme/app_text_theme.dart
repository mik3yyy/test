import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText {
  static TextStyle header1(BuildContext context, Color color, double size) {
    return Theme.of(context).textTheme.headline1!.copyWith(
        fontSize: size,
        fontWeight: FontWeight.w800,
        fontFamily: 'Avenir LTStd',
        color: color);
  }

  static TextStyle header2(BuildContext context, Color color, double size) {
    return Theme.of(context).textTheme.headline1!.copyWith(
        fontSize: size,
        fontWeight: FontWeight.w700,
        fontFamily: 'Avenir LTStd',
        color: color);
  }

  static TextStyle header3(BuildContext context, Color color, double size) {
    return Theme.of(context).textTheme.headline1!.copyWith(
          fontSize: size,
          fontWeight: FontWeight.w900,
          fontFamily: 'Avenir LTStd',
          color: color,
        );
  }

  static TextStyle body1(BuildContext context, Color color) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
        fontSize: 25.0.sp,
        fontWeight: FontWeight.w400,
        fontFamily: 'Avenir LTStd',
        color: color);
  }

  static TextStyle body4(BuildContext context, Color color) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
        fontSize: 18.0.sp,
        fontWeight: FontWeight.w400,
        fontFamily: 'Avenir LTStd',
        color: color);
  }

  static TextStyle body2(BuildContext context, Color color, double size) {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
        fontSize: size,
        fontWeight: FontWeight.w400,
        fontFamily: 'Avenir LTStd',
        color: color);
  }

  static TextStyle body2Bold(BuildContext context, Color color, double size) {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
        fontSize: size,
        fontWeight: FontWeight.w800,
        fontFamily: 'Avenir LTStd',
        color: color);
  }

  static TextStyle debitCard(
      BuildContext context, Color color, double size, double spacing) {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
        fontSize: size,
        letterSpacing: spacing,
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

  static TextStyle buttonText(BuildContext context, Color color) {
    return Theme.of(context).textTheme.bodyText2!.copyWith(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          fontFamily: 'Avenir LTStd',
          color: color,
        );
  }

  static TextStyle label(BuildContext context, Color color) {
    return Theme.of(context).textTheme.labelSmall!.copyWith(
        fontSize: 19.5.sp,
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

  //TextSTyle for seelected text in bottom bar
  static TextStyle bottomBarText(BuildContext context, Color color) {
    return Theme.of(context).textTheme.labelSmall!.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        fontFamily: 'Avenir LTStd',
        color: color);
  }

  //TextSTyle for contact name text
  static TextStyle contactNameStyle(BuildContext context, Color color) {
    return Theme.of(context).textTheme.labelSmall!.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w900,
        fontFamily: 'Roboto',
        color: color);
  }

  //TextSTyle for contact name text
  static TextStyle body5(BuildContext context, Color color, double size) {
    return GoogleFonts.roboto(
        textStyle: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.bold,
    ));
  }

  //TextSTyle for contact name text
  static TextStyle body6(BuildContext context, Color color, double size) {
    return GoogleFonts.roboto(
        textStyle: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w500,
    ));
  }
  // //TextSTyle for contact name text
  // static TextStyle body5(BuildContext context, Color color) {
  //   return Theme.of(context).textTheme.labelSmall!.copyWith(
  //       fontSize: 14.sp,
  //       fontWeight: FontWeight.w900,
  //       fontFamily: 'Roboto',
  //       color: color);
  // }
}
