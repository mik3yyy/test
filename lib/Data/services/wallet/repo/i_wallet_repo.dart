import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/create_wallet_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/currency_transactions.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/set_default_as_wallet_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/user_account_details_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/user_saved_wallet_beneficiary_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/verify_acct_no_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/wallet_transactions.dart';

abstract class IWalletRepo {
  Future<CreateWalletRes> createWallet(String currency);
  Future<UserAccountDetails> getUserAccountDetails();
  Future<SetWalletAsDefaultRes> setWalletAsDefault(String currency);
  Future<CurrencyTransaction> currencyTransactions(String currency);

  Future<bool> transferToWallet(
    String fromCurrency,
    String toCurrency,
    num transferAmount,
    String transactionPin,
  );
  Future<bool> transferToAnotherUser(
    String accountNo,
    String transferCurrency,
    num transferAmount,
    String transactionPin,
    bool saveAsBeneficary,
  );

  Future<WalletTransactions> getTransactions();
  Future<VerifyAcctNoRes> verifyAcctNo(String accountNo);
  Future<UserSavedWalletBeneficiaryRes> userSavedWalletBeneficiary();
}
