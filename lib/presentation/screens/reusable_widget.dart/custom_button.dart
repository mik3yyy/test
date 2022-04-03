import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color bgColor;
  final Color? borderColor;
  final Color textColor;
  final double buttonHeight;
  final void Function()? onPressed;
  const CustomButton({
    required this.buttonText,
    required this.bgColor,
    required this.textColor,
    required this.buttonHeight,
    this.onPressed,
    this.borderColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0.0, 11.0, 0.0, 11.0),
      height: buttonHeight,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
            side: BorderSide(
              color: borderColor!,
              width: 0,
            ),
          ),
        ),
        onPressed: onPressed,
        child: Center(
          child: Text(
            buttonText,
            style: AppText.buttonText(context, Colors.white),
          ),
        ),
      ),
    );
  }
}
