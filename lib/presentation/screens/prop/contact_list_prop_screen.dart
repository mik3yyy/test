import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/invite%20friend/widget/contact_list_build.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';

class ContactListPropScreen extends StatelessWidget {
  const ContactListPropScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WalletViewWidget(
        appBar: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.chevron_left,
                  color: AppColors.whiteColor,
                  size: 25.sp,
                ),
                Text(
                  'Add friends',
                  style: AppText.buttonText(
                    context,
                    AppColors.whiteColor,
                  ),
                ),
                CustomButton(
                  borderColor: AppColors.whiteColor,
                  buttonText: 'Invite',
                  bgColor: Colors.transparent,
                  textColor: AppColors.whiteColor,
                  buttonWidth: 66.w,
                ),
              ],
            ),
          ]),
        ),
        child: Container(
          height: 700.h,
          padding:
              EdgeInsets.only(left: 25.w, right: 25.w, top: 15.w, bottom: 39.w),
          child: const ContactListBuild(),
        ),
      ),
    );
  }
}
