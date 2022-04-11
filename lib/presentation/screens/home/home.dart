import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../components/app image/app_image.dart';
import '../../components/app text theme/app_text_theme.dart';
import '../wallet/widget/wallet_list_model/wallet_categories.dart';
import '../wallet/widget/wallet_list_model/wallet_option_list.dart';

class HomePage extends StatelessWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  const HomePage(
      {Key? key,
      required this.menuScreenContext,
      required this.onScreenHideButtonPressed,
      required this.hideStatus})
      : super(key: key);

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
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '\$2,400.00',
                        style: AppText.header1(context, Colors.white, 25.sp),
                      ),
                      Space(10.h),
                      Text(
                        'Available Balance',
                        style: AppText.body2(context, Colors.white, 16.sp),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                  Space(10.w),
                  const CircleAvatar(
                    radius: 18.0,
                    backgroundImage: AssetImage(
                      AppImage.image1,
                    ),
                  )
                ],
              ),
              Space(30.h),
              const WalletOptionList()
            ],
          ),
        ),
        child: SizedBox(
          height: 600.h,
          child: Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 30.h),
              child: const WalletCategory()),
        ),
      ),
    );
  }
}
