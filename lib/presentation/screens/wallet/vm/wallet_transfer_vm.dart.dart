import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/repo/wallet_repo.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/notification/viewmodel/get_notification_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/wallet_transactions.dart';

final transferToWalletProvider =
    StateNotifierProvider<TransferToWalletVM, RequestState<bool>>(
  (ref) => TransferToWalletVM(ref),
);

class TransferToWalletVM extends RequestStateNotifier<bool> {
  final Ref ref;

  TransferToWalletVM(this.ref);

  Future<RequestState<bool>> transferToWallet(String fromCurrency,
          String toCurrency, num transferAmount, String transactionPin) =>
      makeRequest(() async {
        final res = await ref.read(walletManagerProvider).transferToWallet(
            fromCurrency, toCurrency, transferAmount, transactionPin);
        if (res) {
          ref.invalidate(userProfileProvider);
          ref.invalidate(remoteNotificationListProvider);
          ref.invalidate(walletTransactionProvider);
          return res;
        } else {
          return !res;
        }
      });

  Future<RequestState<bool>> transferToAnotherUser(
          String accountNo,
          String transferCurrency,
          num transferAmount,
          String transactionPin,
          bool saveAsBeneficary) =>
      makeRequest(() async {
        final res = await ref.read(walletManagerProvider).transferToAnotherUser(
            accountNo,
            transferCurrency,
            transferAmount,
            transactionPin,
            saveAsBeneficary);
        if (res) {
          ref.invalidate(userProfileProvider);
          ref.invalidate(remoteNotificationListProvider);
          ref.invalidate(walletTransactionProvider);
          return res;
        } else {
          return !res;
        }
      });
}
