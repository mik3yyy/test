import 'package:flutter/material.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';

class SuccessDialog extends ModalRoute<void> {
  String message;
  String buttonText;
  VoidCallback? buttonClicked;

  SuccessDialog(
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
  Color get barrierColor => Colors.black.withOpacity(0.3);

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
    var edgePaddingPercentage = MediaQuery.of(context).size.width * 0.7;
    var side = MediaQuery.of(context).size.width - edgePaddingPercentage;
    var sidePadding = side / 2;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: sidePadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 25),
            const Image(
              image: AssetImage(AppImage.successIcon),
            ),
            const SizedBox(height: 8),
            Text(
              'Success!',
              style: AppText.body4(context, AppColors.appColor),
            ),
            // Container(
            //   height: 180,
            //   width: 180,
            //   alignment: Alignment.center,
            //   child: Lottie.asset(
            //     'resources/lotties/error.json',
            //     reverse: false,
            //     repeat: false,
            //   ),
            // ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                message,
                textAlign: TextAlign.center,
                maxLines: 4,
                style: AppText.body4(context, AppColors.appColor),
              ),
            ),
            // const SizedBox(height: 10),
            getBottomContent(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget getBottomContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
      child: TextButton(
          onPressed: () {
            buttonClicked?.call();
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.appColor,
            disabledBackgroundColor: AppColors.appColor,
          ),
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            maxLines: 4,
            style: AppText.body4(context, Colors.white),
          )),
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
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
