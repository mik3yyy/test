import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_list_model/wallet_options.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../components/app text theme/app_text_theme.dart';

class WalletOptionList extends StatelessWidget {
  const WalletOptionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
      ),
      height: 110.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: walletOptions.length,
        itemBuilder: (context, index) {
          final options = walletOptions[index];
          return Column(
            children: [
              Container(
                height: 70.h,
                width: 70.w,
                decoration: BoxDecoration(
                    border:
                        Border.all(width: 2.w, color: AppColors.bottomSheet)),
                child: Image(image: AssetImage(options.image)),
              ),
              Space(15.h),
              Text(
                options.name,
                style: AppText.body2(context, Colors.white, 16.sp),
              )
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 25.w,
          );
        },
      ),
    );
  }
}
