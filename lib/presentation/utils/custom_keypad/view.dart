import 'package:flutter/material.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/custom_keypad/pin_keyboard.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/custom_keypad/pin_keyboard_controller.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class View extends StatefulWidget {
  const View({Key? key}) : super(key: key);

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
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

  @override
  Widget build(BuildContext context) {
    final code = _inputList.join("");

    final result =
        RegExp(r".{1}").allMatches(code).map((e) => e.group(0)).join('   ');
    return Scaffold(
      body: Column(
        children: [
          const Space(100),
          Text(result),
          const Space(100),
          PinKeyboard(
            textColor: Colors.black,
            length: 4,
            controller: _pinKeyboardController,
            onConfirm: (value) {
              print(value);
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
