import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app text theme/app_text_theme.dart';
import '../../../components/reusable_widget.dart/custom_button.dart';
import '../../../components/reusable_widget.dart/in_app_keyboard.dart';

class ConfirmTransactionPinScreen extends HookConsumerWidget {
  ConfirmTransactionPinScreen({Key? key}) : super(key: key);
  final toggleStateProvider = StateProvider<bool>((ref) {
    return false;
  });

  final List<String> _keyRowOne = ['1', '2', '3'];
  List<String> get keyRowOne => _keyRowOne;
  final List<String> _keyRowTwo = ['4', '5', '6'];
  List<String> get keyRowTwo => _keyRowTwo;
  final List<String> _keyRowThree = ['7', '8', '9'];
  List<String> get keyRowThree => _keyRowThree;
  final List<String> _keyRowFour = [' . ', '0', '<'];
  List<String> get keyRowFour => _keyRowFour;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldController = useTextEditingController();
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Confirm your PIN",
                style: AppText.header3(context, AppColors.appColor, 20.sp),
                textAlign: TextAlign.center,
              ),
              Space(19.h),
              Text(
                "This pin will be used for Transactions",
                style: AppText.header2(context, AppColors.appColor, 20.sp),
                textAlign: TextAlign.center,
              ),
              Space(60.h),
              KeyboaedField(
                fieldController: fieldController,
                keyRowOne: _keyRowOne,
                keyRowTwo: _keyRowTwo,
                keyRowThree: _keyRowThree,
                keyRowFour: _keyRowFour,
              ),
              Space(120.h),
              CustomButton(
                buttonWidth: double.infinity,
                buttonText: 'Confirm PIN',
                bgColor: AppColors.appColor,
                borderColor: AppColors.appColor,
                textColor: Colors.white,
                onPressed: () {
                  // context.navigate(TransactionPinScreen());
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
