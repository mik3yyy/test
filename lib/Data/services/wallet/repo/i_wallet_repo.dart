import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/create_wallet_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/set_default_as_wallet_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/user_account_details_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/wallet_transactions.dart';

abstract class IWalletRepo {
  Future<CreateWalletRes> createWallet(String currency);
  Future<UserAccountDetails> getUserAccountDetails();
  Future<SetWalletAsDefaultRes> setWalletAsDefault(String currency);

  Future<bool> transferToWallet(
    String fromCurrency,
    String toCurrency,
    num transferAmount,
    String transactionPin,
  );
  // //Transafer to other wallet
  // Future<bool> transferToAnotherUser(
  //   String accountNo,
  //   String transferCurrency,
  //   num transferAmount,
  //   String transactionPin,
  // );

  Future<WalletTransactions> getTransactions();
}
