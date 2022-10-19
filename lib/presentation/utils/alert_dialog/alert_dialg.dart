import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class UnAuthenticatedDialog extends ModalRoute<void> {
  String message;
  String buttonText;
  VoidCallback? buttonClicked;

  UnAuthenticatedDialog(
    this.message, {
    this.buttonText = "Try again",
    @required this.buttonClicked,
  });

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    // var edgePaddingPercentage = MediaQuery.of(context).size.width * 0.7;
    // var side = MediaQuery.of(context).size.width - edgePaddingPercentage;
    // var sidePadding = side / 2;
    if (Platform.isIOS) {
      return buildCupertinoWidget(context);
    } else {
      return AlertDialog(
        title: const Text("Info"),
        content:
            Text(message, style: AppText.body2(context, Colors.black, 16.sp)),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  buttonClicked?.call();
                },
                child: Text("Ok",
                    style: AppText.body2(context, Colors.blue, 20.sp)),
              ),
            ),
          )
        ],
      );
    }
  }

  Widget getBottomContent(BuildContext context) {
    if (Platform.isIOS) {
      return buildCupertinoWidget(context);
    } else {
      return Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
        child: TextButton(
            onPressed: () {
              buttonClicked?.call();
            },
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: AppColors.appColor,
              onSurface: AppColors.appColor,
            ),
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
              maxLines: 4,
              style: AppText.body4(context, Colors.white),
            )),
      );
    }
  }

  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        'Info',
        style: AppText.header2(context, Colors.black, 20.sp),
      ),
      content: Column(
        children: [
          const Space(20),
          Text(message, style: AppText.body2(context, Colors.black, 16.sp))
        ],
      ),
      actions: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                buttonClicked?.call();
              },
              child: Text(buttonText,
                  style: AppText.body2(context, AppColors.appColor, 20.sp)),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
