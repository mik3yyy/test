import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/repo/wallet_repo.dart';

final transferToWalletProvider =
    StateNotifierProvider<TransferToWalletVM, RequestState<bool>>(
  (ref) => TransferToWalletVM(ref),
);

class TransferToWalletVM extends RequestStateNotifier<bool> {
  final WalletRepo _walletRepo;

  TransferToWalletVM(Ref ref) : _walletRepo = ref.read(walletManagerProvider);

  Future<RequestState<bool>> transferToWallet(String fromCurrency,
          String toCurrency, num transferAmount, String transactionPin) =>
      makeRequest(() => _walletRepo.transferToWallet(
          fromCurrency, toCurrency, transferAmount, transactionPin));

  Future<RequestState<bool>> transferToAnotherUser(
    String accountNo,
    String transferCurrency,
    num transferAmount,
    String transactionPin,
  ) =>
      makeRequest(() => _walletRepo.transferToAnotherUser(
          accountNo, transferCurrency, transferAmount, transactionPin));
}
