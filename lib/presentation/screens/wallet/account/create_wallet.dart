import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/account/available_wallet.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/account/no_wallet.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/get_account_details_vm.dart';

class CreateWallet extends StatefulHookConsumerWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  const CreateWallet(
      {Key? key,
      required this.menuScreenContext,
      required this.onScreenHideButtonPressed,
      required this.hideStatus})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateWalletState();
}

class _CreateWalletState extends ConsumerState<CreateWallet> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(getAccountDetailsProvider);
    return vm.when(success: (value) {
      //Checking if user wallet is empty, then show no wallet screen else show list of wallet available
      return value!.data!.wallets!.isEmpty
          ? const NoWalletWidget()
          : AvailableWallet(
              wallet: value.data!.wallets!,
            );
    }, error: (Object error, StackTrace? stackTrace) {
      return Center(
        child: Text(
          error.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }, idle: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
