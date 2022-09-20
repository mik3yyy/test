import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/swiftcode/search_box.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class FaqAppBar extends StatelessWidget {
  const FaqAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Column(
        children: [
          Space(20.h),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (() => Navigator.pop(context)),
                child: const Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.white,
                ),
              ),
              Space(22.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Faq'.toUpperCase(),
                    style: AppText.robotoStyle(
                      context,
                      AppColors.whiteColor,
                      20.sp,
                      FontWeight.w600,
                    ),
                  ),
                  Space(6.h),
                  Text(
                    'Frequently asked questions',
                    style: AppText.robotoStyle(
                      context,
                      AppColors.whiteColor,
                      14.sp,
                      FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Space(0),
            ],
          ),
          Space(18.h),
          SizedBox(
              height: 46.h,
              child: const SearchBox(
                hintText: 'Search FAQ',
              )),
          Space(0.h),
        ],
      ),
    );
  }
}
