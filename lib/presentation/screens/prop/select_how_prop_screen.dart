import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class SelectHowPropScreen extends StatelessWidget {
  const SelectHowPropScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.appColor,
        appBar: AppBar(
          leading: const BackButton(),
          centerTitle: true,
          title: const AppBarTitle(title: "Messages", color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            children: [
              const Space(50),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(45.r)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You have No contact\nAdd a new contact and connect with friends",
                        textAlign: TextAlign.center,
                        style:
                            AppText.header2(context, AppColors.appColor, 19.sp),
                      ),
                      const Space(20),
                      Container(
                        child: Center(
                          child: Text(
                            "Add Contact",
                            textAlign: TextAlign.center,
                            style: AppText.header2(
                                context, AppColors.appColor, 19.sp),
                          ),
                        ),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey.shade200,
                      ),
                      Space(100.h),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ));
  }
}
