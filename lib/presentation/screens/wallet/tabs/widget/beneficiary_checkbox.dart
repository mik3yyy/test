import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';

import '../../../../components/app text theme/app_text_theme.dart';

class SaveBeneficiaryCheckBox extends StatelessWidget {
  final ValueNotifier<bool> saved;
  const SaveBeneficiaryCheckBox({Key? key, required this.saved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        controlAffinity: ListTileControlAffinity.leading,
        value: saved.value,
        checkColor: Colors.white,
        activeColor: AppColors.appColor,
        // selectedTileColor: AppColors.primaryColor,
        // title: Transform.translate(offset: Offset(-15,0),
        title: Transform.translate(
          offset: const Offset(-17, 0),
          child: Text(
            'Save beneficiary',
            style: AppText.body2(context, AppColors.appColor, 18.sp),
          ),
        ),
        onChanged: (newValue) {
          saved.value = newValue!;
          // print(saved.value);
        });
  }
}
