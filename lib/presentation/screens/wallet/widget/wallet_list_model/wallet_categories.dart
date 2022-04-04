import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../components/app text theme/app_text_theme.dart';
import 'wallet_options.dart';

class WalletCategory extends StatelessWidget {
  const WalletCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
      ),
      height: 450.h,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        itemCount: walletCategories.length,
        itemBuilder: (context, index) {
          final category = walletCategories[index];
          return Row(
            children: [
              Container(
                height: 150.h,
                width: 150.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(width: 2.w, color: Colors.white)),
                child: Column(
                  children: [
                    Space(40.h),
                    Container(
                      height: 45.h,
                      width: 45.h,
                      // color: Colors.red,
                      child: Image(
                          fit: BoxFit.contain,
                          image: AssetImage(category.image)),
                    ),
                    Space(12.h),
                    Text(
                      category.name,
                      style: AppText.body2(context, AppColors.appColor, 20.sp),
                    )
                  ],
                ),
              ),
              Space(15.h),
              Container(
                width: 200.w,
                child: Text(
                  category.description,
                  style: AppText.body2(context, AppColors.appColor, 16.sp),
                ),
              )
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 25.w,
          );
        },
      ),
    );
  }
}
