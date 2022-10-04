import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';

class AppBarTitle extends StatelessWidget {
  final String title;
  final Color color;
  const AppBarTitle({Key? key, required this.title, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppText.header2(context, color, 19.sp),
    );
  }
}
