import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/models/message_model.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class BuildMessageWidget extends StatelessWidget {
  final Message message;
  final bool isMe;
  const BuildMessageWidget({
    required this.message,
    required this.isMe,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isMe
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        message.time,
                        style: AppText.body2(
                          context,
                          AppColors.lightAppColor,
                          14.sp,
                        ),
                      ),
                      Space(27.w),
                      Expanded(
                        child: Text(
                          message.text,
                          textAlign: TextAlign.right,
                          style: AppText.body2(
                            context,
                            AppColors.appColor,
                            16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          message.text,
                          textAlign: TextAlign.left,
                          style: AppText.body2(
                            context,
                            AppColors.appColor,
                            16.sp,
                          ),
                        ),
                      ),
                      Space(27.w),
                      Text(
                        message.time,
                        style: AppText.body2(
                          context,
                          AppColors.lightAppColor,
                          14.sp,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              ),
      ],
    );
  }
}
