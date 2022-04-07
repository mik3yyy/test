import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class ShareOptionDetails extends StatefulWidget {
  const ShareOptionDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<ShareOptionDetails> createState() => _ShareOptionDetailsState();
}

class _ShareOptionDetailsState extends State<ShareOptionDetails> {
  final List<ShareDetails> _shareDetails = [
    ShareDetails(text: 'Contacts in area', isTap: false),
    ShareDetails(text: 'Phone Contact', isTap: false),
    ShareDetails(text: 'Email Contact', isTap: false),
  ];

  // bool isTap = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: ListView.builder(
        itemCount: _shareDetails.length,
        itemBuilder: (BuildContext context, int index) {
          final item = _shareDetails[index];
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    item.isTap = !item.isTap;
                    // if (item.isTap == false) {
                    //   item.isTap = true;
                    // } else {
                    //   item.isTap == false;
                    // }
                  });

                  print(item.text);
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
                  decoration: BoxDecoration(
                      // color: AppColors.whiteColor,
                      border: Border.all(
                        color: item.isTap == false
                            ? Colors.transparent
                            : AppColors.referFriendBorderColor2,
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(3.r)),
                  child: Center(
                    child: Text(
                      item.text,
                      style: AppText.body3(
                        context,
                        AppColors.appColor,
                      ),
                    ),
                  ),
                ),
              ),
              Space(18.h),
            ],
          );
        },
      ),
      // ListView.separated(
      //   itemCount: _shareDetails.length,
      // itemBuilder: (BuildContext context, int index) {
      //   final item = _shareDetails[index];
      //   return Container(
      //     padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
      //     decoration: BoxDecoration(
      //         // color: AppColors.whiteColor,
      //         border: Border.all(
      //           color: AppColors.referFriendBorderColor2,
      //           width: 1.w,
      //         ),
      //         borderRadius: BorderRadius.circular(3.r)),
      //     child: Center(
      //       child: Text(
      //         item.text,
      //         style: AppText.body3(
      //           context,
      //           AppColors.appColor,
      //         ),
      //       ),
      //     ),
      //   );
      // },
      //   separatorBuilder: (BuildContext context, int index) {
      //     return Space(18.h);
      //   },
      // ),
    );

    // Column(
    //   children: [
    //     Container(
    //       child: Center(
    //         child: Text(
    //           'Contacts in area',
    //           style: AppText.body3(
    //             context,
    //             AppColors.appColor,
    //           ),
    //         ),
    //       ),
    //     ),
    //     Space(18.h),
    // Container(
    //   padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
    //   decoration: BoxDecoration(
    //       // color: AppColors.whiteColor,
    //       border: Border.all(
    //         color: AppColors.referFriendBorderColor2,
    //         width: 1.w,
    //       ),
    //       borderRadius: BorderRadius.circular(3.r)),
    //   child: Center(
    //     child: Text(
    //       'Phone Contact',
    //       style: AppText.body3(
    //         context,
    //         AppColors.appColor,
    //       ),
    //     ),
    //   ),
    // ),
    //     Space(18.h),
    //     Container(
    //       child: Center(
    //         child: Text(
    //           'Email Contact',
    //           style: AppText.body3(
    //             context,
    //             AppColors.appColor,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}

class ShareDetails {
  final String text;
  bool isTap;

  ShareDetails({
    required this.text,
    required this.isTap,
  });
}
