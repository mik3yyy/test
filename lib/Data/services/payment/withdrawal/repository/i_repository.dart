import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_details_req/bank_details_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_details_res/bank_details_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_res.dart';

abstract class IRepository {
  Future<BankRes> fetchBank();
  Future<BankDetailsRes> getBankDetails(
      GetBankAccountDetails getBankAccountDetails);
}
