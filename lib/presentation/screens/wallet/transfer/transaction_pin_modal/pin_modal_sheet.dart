import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/shared/enable_modal_route_source.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/wallet_transfer_vm.dart.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/custom_keypad/pin_keyboard.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/custom_keypad/pin_keyboard_controller.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class PinModalSheet extends StatefulHookConsumerWidget {
  final String fromCurrency;
  final String toCurrency;
  final ModalRouteName routeName;
  final bool saveBeneficiary;
  final num transferAmount;

  const PinModalSheet(
      {Key? key,
      required this.routeName,
      required this.fromCurrency,
      required this.saveBeneficiary,
      required this.toCurrency,
      required this.transferAmount})
      : super(key: key);

  @override
  _PinModalSheetState createState() => _PinModalSheetState();
}

class _PinModalSheetState extends ConsumerState<PinModalSheet> {
  TextEditingController controller = TextEditingController();
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
    final code = _inputList.join("");

    final result =
        RegExp(r".{1}").allMatches(code).map((e) => e.group(0)).join('   ');

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Space(50.h),
          const SecurityDisplayHeader(),
          const Space(40),
          Container(
            height: 50,
            width: 190,
            decoration:
                BoxDecoration(border: Border.all(color: AppColors.appColor)),
            child: Center(
              child: isObscure == true
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
          const Space(40),
          PinKeyboard(
            enableBiometric: true,
            textColor: Colors.black,
            length: 4,
            controller: _pinKeyboardController,
            onConfirm: (value) {
              if (value.length == 4) {
                switch (widget.routeName) {
                  case ModalRouteName.toWallet:
                    Navigator.pop(context);
                    ref
                        .read(transferToWalletProvider.notifier)
                        .transferToWallet(
                          widget.fromCurrency,
                          widget.toCurrency,
                          widget.transferAmount,
                          value,
                        );

                    break;
                  case ModalRouteName.toFriend:
                    Navigator.pop(context);
                    ref
                        .read(transferToWalletProvider.notifier)
                        .transferToAnotherUser(
                          widget.fromCurrency,
                          widget.toCurrency,
                          widget.transferAmount,
                          value,
                          widget.saveBeneficiary,
                        );

                    break;
                  default:
                }
              }
            },
            onChange: (String? value) {
              _setTextToInput(value!);

              setState(() {
                text = value;
              });
            },
            // iconBackspace:
            //     IconButton(onPressed: () {

            //     }, icon: const Icon(Icons.backspace)),
            // iconBiometric: SizedBox(
            //   height: 80.h,
            //   width: 80.w,
            //   child: const Image(
            //     image: AssetImage(
            //       "assets/images/fingerprint-3.png",
            //     ),
            //     color: AppColors.appColor,
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}

class SecurityDisplayHeader extends StatelessWidget {
  const SecurityDisplayHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 80.h,
      width: MediaQuery.of(context).size.width,
      color: AppColors.appColor.withOpacity(0.05),
      child: Row(
        children: [
          Space(20.w),
          const Icon(
            Icons.security,
            size: 30,
          ),
          Space(15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'For security reasons',
                style: AppText.header2(context, Colors.black, 20.sp),
              ),
              const Space(2),
              Text(
                'Enter transaction PIN',
                style: AppText.body2Bold(context, Colors.black, 23.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
