import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utils/widget_spacer.dart';
import '../app text theme/app_text_theme.dart';
import '../color/value.dart';

class KeyPad extends StatelessWidget {
  final String? title;
  final VoidCallback? ontap;
  const KeyPad({Key? key, this.title, this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Ink(
        child: Center(
          child: Text(
            title!,
            style: AppText.body2(context, AppColors.textColor, 30.h),
          ),
        ),
      ),
    );
  }
}

class KeyboaedField extends StatelessWidget {
  const KeyboaedField({
    Key? key,
    required this.fieldController,
    required List<String> keyRowOne,
    required List<String> keyRowTwo,
    required List<String> keyRowThree,
    required List<String> keyRowFour,
  })  : _keyRowOne = keyRowOne,
        _keyRowTwo = keyRowTwo,
        _keyRowThree = keyRowThree,
        _keyRowFour = keyRowFour,
        super(key: key);

  final TextEditingController fieldController;
  final List<String> _keyRowOne;
  final List<String> _keyRowTwo;
  final List<String> _keyRowThree;
  final List<String> _keyRowFour;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          PinCodeTextField(
            useExternalAutoFillGroup: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'otp is required';
              }
              if (value.length < 4) {
                return null;
              }

              // validator has to return something :)
              return null;
            },
            pinTheme: PinTheme(
              inactiveColor: AppColors.hintColor,
              inactiveFillColor: AppColors.hintColor,
              activeColor: AppColors.greenColor,
              shape: PinCodeFieldShape.underline,
              selectedColor: AppColors.greenColor,
              activeFillColor: AppColors.greenColor,
            ),
            controller: fieldController,
            cursorColor: AppColors.greenColor,
            hintCharacter: "*",
            autoDismissKeyboard: true,
            readOnly: true,
            focusNode: FocusNode(),
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            appContext: context,
            length: 4,
            onCompleted: (value) {
              // ref.read(toggleStateProvider.notifier).state =
              //     toggleState == false ? true : false;
              // toggleState = true;
            },
            onChanged: (String value) {},
          ),
          Space(60.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _keyRowOne
                .map(
                  (e) => KeyPad(
                    key: Key(e),
                    title: e,
                    ontap: () {
                      fieldController.text = '${fieldController.text}$e';
                      fieldController.selection = TextSelection.collapsed(
                          offset: fieldController.text.length);
                    },
                  ),
                )
                .toList(),
          ),
          Divider(
            height: 40.h,
            indent: 29.w,
            endIndent: 29.w,
            thickness: 1.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _keyRowTwo
                .map(
                  (e) => KeyPad(
                    key: Key(e),
                    title: e,
                    ontap: () {
                      fieldController.text = '${fieldController.text}$e';
                      fieldController.selection = TextSelection.collapsed(
                          offset: fieldController.text.length);
                    },
                  ),
                )
                .toList(),
          ),
          Divider(
            height: 40.h,
            indent: 29.w,
            endIndent: 29.w,
            thickness: 1.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _keyRowThree
                .map(
                  (e) => KeyPad(
                    key: Key(e),
                    title: e,
                    ontap: () {
                      fieldController.text = '${fieldController.text}$e';
                      fieldController.selection = TextSelection.collapsed(
                          offset: fieldController.text.length);
                    },
                  ),
                )
                .toList(),
          ),
          Divider(
            height: 40.h,
            indent: 29.w,
            endIndent: 29.w,
            thickness: 1.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _keyRowFour
                .map(
                  (e) => KeyPad(
                    key: Key(e),
                    title: e,
                    ontap: () {
                      if (e == "<") {
                        if (fieldController.value.text.isNotEmpty) {
                          fieldController.text = fieldController.value.text
                              .substring(
                                  0, fieldController.value.text.length - 1);
                          fieldController.selection = TextSelection.collapsed(
                              offset: fieldController.value.text.length);
                        }
                      } else {
                        fieldController.text = '${fieldController.text}$e';
                        fieldController.selection = TextSelection.collapsed(
                            offset: fieldController.text.length);
                      }
                    },
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
