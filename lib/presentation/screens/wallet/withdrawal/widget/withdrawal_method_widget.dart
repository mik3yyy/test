import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../components/app text theme/app_text_theme.dart';

class WithdrawMethod extends StatelessWidget {
  final String method;
  final void Function()? onPressed;
  const WithdrawMethod(
      {Key? key, required this.method, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 90,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 20.w, top: 40.h),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
        child: Text(
          method,
          style: AppText.body2Bold(context, Colors.black54, 22.sp),
        ),
      ),
    );
  }
}
