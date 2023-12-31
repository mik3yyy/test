import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/create_wallet_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/currency_transactions.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/set_default_as_wallet_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/user_account_details_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/user_saved_wallet_beneficiary_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/verify_acct_no_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/wallet_transactions.dart';
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
      num transferAmount, String transactionPin, bool saveAsBeneficary) async {
    final res = await _walletService.transferToAnotherUser(accountNo,
        transferCurrency, transferAmount, transactionPin, saveAsBeneficary);
    return res;
  }

  @override
  Future<WalletTransactions> getTransactions() async {
    final wallet = await _walletService.getTransactions();
    // if (wallet.data!.transactions.isNotEmpty) {
    //   SaveWalletTransaction().saveWalletTransaction(wallet.data!.transactions);
    // }

    return wallet;
  }

  @override
  Future<VerifyAcctNoRes> verifyAcctNo(String accountNo) async {
    final res = await _walletService.verifyAcctNo(accountNo);
    return res;
  }

  @override
  Future<UserSavedWalletBeneficiaryRes> userSavedWalletBeneficiary() async {
    final res = await _walletService.userSavedWalletBeneficiary();
    return res;
  }

  @override
  Future<CurrencyTransaction> currencyTransactions(String currency) async {
    final res = await _walletService.currencyTransactions(currency);
    return res;
  }
}
