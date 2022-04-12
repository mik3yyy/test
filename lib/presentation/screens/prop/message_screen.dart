import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WalletViewWidget(
        appBar: Padding(
          padding: EdgeInsets.only(left: 18.w, right: 18.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.chevron_left,
                color: AppColors.whiteColor,
              ),
              Image.asset(AppImage.messageMenuIcon),
            ],
          ),
        ),
        child: Container(
          height: 750.h,
          padding:
              EdgeInsets.only(left: 25.w, right: 25.w, top: 15.w, bottom: 39.w),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
