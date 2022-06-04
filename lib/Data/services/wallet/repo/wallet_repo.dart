import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/create_wallet_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/set_default_as_wallet_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/user_account_details_res.dart';
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
  Future<WalletTransactions> getTransactions() async =>
      await _walletService.getTransactions();
}
