import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/widget/share_option_prop.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class SelectHowPropScreen extends StatelessWidget {
  const SelectHowPropScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WalletViewWidget(
        appBar: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [],
              ),
            ],
          ),
        ),
        child: Container(
          height: 850.h,
          padding:
              EdgeInsets.only(left: 25.w, right: 25.w, top: 15.w, bottom: 39.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.chevron_left,
                    color: AppColors.appColor,
                  ),
                  Text(
                    'Messages',
                    style: AppText.body3(
                      context,
                      AppColors.appColor,
                    ),
                  ),
                  const Space(0),
                ],
              ),
              Space(100.h),
              Container(
                height: 300.h,
                padding: const EdgeInsets.fromLTRB(14.0, 10.0, 14.0, 10.0),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  border: Border.all(
                    color: AppColors.borderColor,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(5.r),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.referFriendBorderColor4,
                      spreadRadius: 0,
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: const ShareOptionProp(),
              ),
              Space(36.h),
              CustomButton(
                borderColor: AppColors.appColor,
                buttonText: "Continue",
                bgColor: AppColors.appColor,
                textColor: AppColors.whiteColor,
                buttonWidth: double.infinity,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
