import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/create_wallet_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/set_default_as_wallet_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/user_account_details_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/repo/i_wallet_repo.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/wallet_service.dart';

final walletManagerProvider = Provider<WalletRepo>((ref) {
  final walletService = ref.watch(walletServiceProvider);

  return WalletRepo(walletService);
});

class WalletRepo extends IWalletRepo {
  final WalletService _walletService;

  WalletRepo(this._walletService);

  @override
  //Create wallet for user
  Future<CreateWalletRes> createWallet(String currency) async {
    final res = await _walletService.createWallet(currency);
    return res;
  }

  @override
  Future<UserAccountDetails> getUserAccountDetails() async {
    final res = await _walletService.getUserAccountDetails();
    return res;
  }

  @override
  Future<SetWalletAsDefaultRes> setWalletAsDefault(String currency) async {
    final res = await _walletService.setWalletAsDefault(currency);
    return res;
  }

  @override
  Future<bool> transferToWallet(String fromCurrency, String toCurrency,
      num transferAmount, String transactionPin) async {
    final res = await _walletService.transferToWallet(
        fromCurrency, toCurrency, transferAmount, transactionPin);
    return res;
  }

  @override
  Future<bool> transferToAnotherUser(String accountNo, String transferCurrency,
      num transferAmount, String transactionPin) async {
    final res = await _walletService.transferToAnotherUser(
        accountNo, transferCurrency, transferAmount, transactionPin);
    return res;
  }
}
