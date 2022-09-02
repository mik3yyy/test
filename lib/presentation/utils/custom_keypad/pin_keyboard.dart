library pin_keyboard;

import 'package:flutter/material.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/custom_keypad/pin_keyboard_controller.dart';

class PinKeyboard extends StatefulWidget {
  final double space;
  final int length;
  final double maxWidth;
  final void Function(String)? onChange;
  final void Function(String)? onConfirm;
  final VoidCallback? onBiometric;
  final bool enableBiometric;
  final Widget? iconBiometric;
  final Widget? iconBackspace;
  final Color? iconBackspaceColor;
  final Color? iconBiometricColor;
  final Color? textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final PinKeyboardController? controller;

  const PinKeyboard({
    Key? key,
    this.space = 50,
    required this.length,
    required this.onChange,
    this.onConfirm,
    this.onBiometric,
    this.enableBiometric = false,
    this.iconBiometric,
    this.maxWidth = 300,
    this.iconBackspaceColor,
    this.iconBiometricColor,
    this.textColor,
    this.fontSize = 30,
    this.fontWeight = FontWeight.w500,
    this.iconBackspace,
    this.controller,
  }) : super(key: key);

  @override
  _PinKeyboardState createState() => _PinKeyboardState();
}

class _PinKeyboardState extends State<PinKeyboard> {
  String _pinCode = '';

  @override
  void initState() {
    _restListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: widget.maxWidth,
      ),
      child: SizedBox(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _createNumber('1', _handleTabNumber),
                const Spacer(),
                _createNumber('2', _handleTabNumber),
                const Spacer(),
                _createNumber('3', _handleTabNumber),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _createNumber('4', _handleTabNumber),
                const Spacer(),
                _createNumber('5', _handleTabNumber),
                const Spacer(),
                _createNumber('6', _handleTabNumber),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _createNumber('7', _handleTabNumber),
                const Spacer(),
                _createNumber('8', _handleTabNumber),
                const Spacer(),
                _createNumber('9', _handleTabNumber),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _createBiometricIcon(),
                const Spacer(),
                _createNumber('0', _handleTabNumber),
                const Spacer(),
                _createBackspaceIcon(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _createNumber(String number, void Function(String) onPress) => InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.space),
        ),
        child: SizedBox(
          height: widget.space,
          width: widget.space,
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontSize: widget.fontSize,
                color: widget.textColor ?? const Color(0xff6f6f6f),
                fontWeight: widget.fontWeight,
              ),
            ),
          ),
        ),
        onTap: () {
          onPress(number);
        },
      );

  Widget _createImage(Widget icon, void Function() onPress) => InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.space),
        ),
        child: SizedBox(
          height: widget.space,
          width: widget.space,
          child: Center(child: icon),
        ),
        onTap: () {
          onPress();
        },
      );

  void _handleTabNumber(String number) {
    if (_pinCode.length < widget.length) {
      // print(number);
      _pinCode += number;
      if (widget.onChange != null) {
        widget.onChange!(_pinCode);
      }
      if (_pinCode.length == widget.length) {
        if (widget.onConfirm != null) {
          widget.onConfirm!(_pinCode);
        }
        if (widget.controller == null) {
          _pinCode = '';
        }
      }
    }
  }

  void _handleTabBiometric() {
    if (widget.onBiometric != null) {
      widget.onBiometric!();
    }
  }

  void _handleTabBackspace() {
    // ignore: prefer_is_empty
    if (_pinCode.length > 0) {
      _pinCode = _pinCode.substring(0, _pinCode.length - 1);
      if (widget.onChange != null) {
        widget.onChange!(_pinCode);
      }
    }
  }

  Widget _createBiometricIcon() {
    if (widget.enableBiometric) {
      return _createImage(
        widget.iconBiometric ??
            Image.asset(
              'assets/images/fingerprint-3.png',
              // package: 'pin_keyboard',
              color: widget.iconBiometricColor ?? const Color(0xff6f6f6f),
            ),
        _handleTabBiometric,
      );
    } else {
      return SizedBox(
        height: widget.space,
        width: widget.space,
      );
    }
  }

  Widget _createBackspaceIcon() => _createImage(
        widget.iconBackspace ??
            Image.asset(
              'assets/images/backButton.png',
              // package: 'pin_keyboard',
              color: widget.iconBackspaceColor ?? Colors.black,
            ),
        _handleTabBackspace,
      );

  void _restListener() {
    widget.controller?.addResetListener(() {
      _pinCode = '';
      if (widget.onChange != null) {
        widget.onChange!('');
      }
    });
  }
}
