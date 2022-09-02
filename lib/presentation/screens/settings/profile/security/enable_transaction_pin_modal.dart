import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/auth_security/auth_secure.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/global/transaction_pin_toggle.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/transfer/transaction_pin_modal/pin_modal_sheet.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/custom_keypad/pin_keyboard.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/custom_keypad/pin_keyboard_controller.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class EnableTransactionPin extends StatefulHookConsumerWidget {
  bool isEnable;
  EnableTransactionPin({Key? key, this.isEnable = false}) : super(key: key);

  @override
  _EnableTransactionPinState createState() => _EnableTransactionPinState();
}

class _EnableTransactionPinState extends ConsumerState<EnableTransactionPin> {
  List<String> _inputList = [];

  final PinKeyboardController _pinKeyboardController = PinKeyboardController();

  String text = "Name";
  void _setTextToInput(String data) async {
    var replaceInputList = List<String>.filled(4, "");

    for (int i = 0; i < 4; i++) {
      replaceInputList[i] = data.length > i ? data[i] : "";
    }

    if (mounted) {
      setState(() {
        _inputList = replaceInputList;
      });
    }
  }

  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    final setPin = ref.watch(setPinStateProvider.state);
    final code = _inputList.join("");

    final result =
        RegExp(r".{1}").allMatches(code).map((e) => e.group(0)).join(' ');

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Space(70.h),
          const SecurityDisplayHeader(),
          const Space(60),
          Container(
            height: 50,
            width: 190,
            decoration:
                BoxDecoration(border: Border.all(color: AppColors.appColor)),
            child: Center(
              child: isObscure == false
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        "*" * code.length,
                        style:
                            AppText.header2(context, AppColors.appColor, 40.sp),
                      ),
                    )
                  : Text(
                      result,
                      style:
                          AppText.header2(context, AppColors.appColor, 40.sp),
                    ),
            ),
          ),
          const Space(100),
          PinKeyboard(
            enableBiometric: true,
            textColor: Colors.black,
            length: 4,
            controller: _pinKeyboardController,
            onConfirm: (value) {
              if (value.length == 4) {
                setState(() {
                  setPin.state = true;
                });

                ref
                    .read(credentialProvider.notifier)
                    .storeCredential(Constants.transactionPin, value);
                Navigator.pop(context);
              } else {}
            },
            onChange: (String? value) {
              _setTextToInput(value!);

              setState(() {
                text = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
