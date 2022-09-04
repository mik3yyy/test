import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/loading_verify.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app text theme/app_text_theme.dart';

class UploadID extends HookConsumerWidget {
  UploadID({Key? key}) : super(key: key);
  final passwordToggleStateProvider = StateProvider<bool>((ref) => true);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final togglePassword = ref.watch(passwordToggleStateProvider.state);
    final fistNameController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Upload ID',
          style: AppText.header2(context, Colors.black, 20.sp),
        ),
        leading: InkWell(
          onTap: (() => Navigator.pop(context)),
          child: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
        child: Column(
          children: [
            Stack(
              children: [
                InkWell(
                  onTap: () {},
                  child: EditForm(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      labelText: 'Country',
                      keyboardType: TextInputType.number,
                      // textAlign: TextAlign.start,
                      controller: fistNameController,
                      obscureText: false,
                      validator: (value) => validateCountry(value)),
                ),
                Positioned(
                  left: 375.w,
                  right: 0,
                  bottom: 17.h,
                  child: const Icon(
                    CupertinoIcons.chevron_down,
                    color: Colors.black,
                    size: 15,
                  ),
                ),
              ],
            ),
            Space(20.h),
            Stack(
              children: [
                InkWell(
                  onTap: () {},
                  child: EditForm(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      labelText: 'ID number',
                      keyboardType: TextInputType.number,
                      // textAlign: TextAlign.start,
                      controller: fistNameController,
                      obscureText: togglePassword.state,
                      validator: (value) => validateCountry(value)),
                ),
                Positioned(
                  left: 370.w,
                  right: 0,
                  bottom: 17.h,
                  child: InkWell(
                    onTap: () {
                      togglePassword.state = !togglePassword.state;
                    },
                    child: Icon(
                      togglePassword.state
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
              ],
            ),
            Space(30.h),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'Upload ID',
                style: AppText.header2(context, AppColors.appColor, 20.sp),
              ),
            ),
            Space(450.h),
            CustomButton(
                buttonText: 'verify',
                bgColor: AppColors.appColor,
                borderColor: AppColors.appColor,
                textColor: Colors.white,
                onPressed: () {
                  pushNewScreen(context,
                      screen: const VerifyScreen(),
                      pageTransitionAnimation: PageTransitionAnimation.fade);
                },
                buttonWidth: MediaQuery.of(context).size.width),
          ],
        ),
      ),
    );
  }
}
