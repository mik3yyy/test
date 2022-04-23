import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';

class ChatDrawerMenu extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const ChatDrawerMenu({
    required this.text,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 38.w),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                text,
                style: AppText.contactNameStyle(
                  context,
                  AppColors.inActiveColor,
                ),
                // textAlign: TextAlign.right,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0),
            child: Divider(
              color: AppColors.whiteColor,
              height: 30.0,
            ),
          ),
        ],
      ),
    );
  }
}
