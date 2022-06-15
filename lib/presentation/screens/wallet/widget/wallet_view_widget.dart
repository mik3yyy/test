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
      fit: StackFit.expand,
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
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(45.r)),
              ),
              // height: 540,
              width: 33.w,
              child: child),
        ),
      ],
    );
  }
}

class GenericWidget extends StatelessWidget {
  final Widget appbar;
  final Widget child;
  final Color bgColor;
  const GenericWidget(
      {Key? key,
      required this.appbar,
      required this.child,
      required this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.appColor,
        body: SafeArea(
          child: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: appbar,
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(45.r)),
                        ),
                        // height: 600,
                        width: double.maxFinite,
                        child: child)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
