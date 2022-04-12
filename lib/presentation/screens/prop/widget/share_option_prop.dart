import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class ShareOptionProp extends StatefulWidget {
  const ShareOptionProp({
    Key? key,
  }) : super(key: key);

  @override
  State<ShareOptionProp> createState() => _ShareOptionPropState();
}

class _ShareOptionPropState extends State<ShareOptionProp> {
  final List<ShareOptionPropDetails> _shareDetails = [
    ShareOptionPropDetails(text: 'Kayndrexsphere account number', isTap: false),
    ShareOptionPropDetails(text: 'Nearby Investors', isTap: false),
    ShareOptionPropDetails(text: 'Phone Contact', isTap: false),
    ShareOptionPropDetails(text: 'Email Contact', isTap: false),
  ];

  // bool isTap = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: ListView.separated(
        itemCount: _shareDetails.length,
        itemBuilder: (BuildContext context, int index) {
          final item = _shareDetails[index];
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    item.isTap = !item.isTap;
                  });
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
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Divider(
              color: AppColors.notificationDividerColor,
              thickness: 1.5,
              height: 20,
              // indent: 5.0,
            ),
          );
        },
      ),

      //  ListView.builder(
      //   itemCount: _shareDetails.length,
      // itemBuilder: (BuildContext context, int index) {
      //   final item = _shareDetails[index];
      //   return Column(
      //     children: [
      //       GestureDetector(
      //         onTap: () {
      //           setState(() {
      //             item.isTap = !item.isTap;
      //             // if (item.isTap == false) {
      //             //   item.isTap = true;
      //             // } else {
      //             //   item.isTap == false;
      //             // }
      //           });

      //           print(item.text);
      //         },
      //         child: Container(
      //           padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
      //           decoration: BoxDecoration(
      //               // color: AppColors.whiteColor,
      //               border: Border.all(
      //                 color: item.isTap == false
      //                     ? Colors.transparent
      //                     : AppColors.referFriendBorderColor2,
      //                 width: 1.w,
      //               ),
      //               borderRadius: BorderRadius.circular(3.r)),
      //           child: Center(
      //             child: Text(
      //               item.text,
      //               style: AppText.body3(
      //                 context,
      //                 AppColors.appColor,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //         Space(18.h),
      //       ],
      //     );
      //   },
      // ),
    );
  }
}

class ShareOptionPropDetails {
  final String text;
  bool isTap;

  ShareOptionPropDetails({
    required this.text,
    required this.isTap,
  });
}
