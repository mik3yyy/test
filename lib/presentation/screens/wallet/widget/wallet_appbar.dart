import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';

class CustomWalletAppBarWithChild extends StatelessWidget {
  final Widget child1;
  final Widget child2;
  final double containerOneHeight;
  final double containerTwoHeight;
  final double containerTwoMargin;
  const CustomWalletAppBarWithChild({
    required this.child1,
    required this.child2,
    required this.containerOneHeight,
    required this.containerTwoHeight,
    required this.containerTwoMargin,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: Alignment.bottomCenter,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 22.0),
          height: containerOneHeight,
          // height: 200.h,
          // height: 165.74.h,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF2E426F),
          ),
          child: child1,
        ),
        Container(
          margin: EdgeInsets.only(top: containerTwoMargin),
          // margin: EdgeInsets.only(top: 150.h),
          // margin: EdgeInsets.only(top: 130.h),
          //TODO: MIght change the height depeneing on the size of the screen
          // height: 900.h,
          height: containerTwoHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            // color: Colors.red,
            color: AppColors.bottomSheet,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
          ),
          child: child2,
        ),
      ],
    );
  }
}
