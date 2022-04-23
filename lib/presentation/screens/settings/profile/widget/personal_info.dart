import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../components/app text theme/app_text_theme.dart';
import '../../../../utils/widget_spacer.dart';

class PersonalInfoCard extends StatelessWidget {
  final String title;
  final String subTitle;

  final Color color;

  const PersonalInfoCard(
      {Key? key,
      required this.title,
      required this.color,
      required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // const hoverColor = Colors.white;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppText.header2(context, Colors.black45, 15.sp),
            ),
            Space(9.h),
            Text(
              subTitle,
              style: AppText.header2(context, Colors.black, 19.sp),
            ),
          ],
        ),
      ],
    );
  }
}
