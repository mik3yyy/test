import 'package:flutter/material.dart';
import 'no_wallet_stepup.dart';
import 'wallet_setup.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isWalletEmpty = true;
    return Scaffold(
        body: isWalletEmpty == false
            ? const NoWalletSetUpWidget()
            : const WalletSetup());
  }
}
