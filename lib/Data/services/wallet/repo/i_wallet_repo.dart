import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/create_wallet_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/set_default_as_wallet_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/user_account_details_res.dart';

abstract class IWalletRepo {
  Future<CreateWalletRes> createWallet(String currency);
  Future<UserAccountDetails> getUserAccountDetails();
  Future<SetWalletAsDefaultRes> setWalletAsDefault(String currency);
}
