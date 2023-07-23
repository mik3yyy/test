import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class SuccessScreen extends StatefulHookConsumerWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends ConsumerState<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 100.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(
                "assets/images/image-4.png",
              ),
              width: 300,
              height: 300,
            ),
            Text(
              'Account created successfully',
              style: AppText.body2(context, AppColors.appColor, 20.sp),
            ),
            Space(170.h),
            CustomButton(
              buttonWidth: double.infinity,
              buttonText: buttonText(context, "Done"),
              bgColor: AppColors.appColor,
              borderColor: AppColors.appColor,
              textColor: Colors.white,
              onPressed: () {
                // ref.read(accountStateProvider.notifier).state =
                //     Account.newAccount;
                context.navigate(const SigninScreen(
                  transactionPin: false,
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
