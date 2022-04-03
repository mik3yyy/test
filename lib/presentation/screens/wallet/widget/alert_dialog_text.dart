import 'package:flutter/material.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';

import '../../../components/app text theme/app_text_theme.dart';

class AlertDailogTextDetails extends StatelessWidget {
  const AlertDailogTextDetails({
    Key? key,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: AppText.body3(
            context,
            AppColors.appColor,
          ),
        ),
        Text(
          text2,
          style: AppText.body3(
            context,
            AppColors.appColor,
          ),
        ),
      ],
    );
  }
}
