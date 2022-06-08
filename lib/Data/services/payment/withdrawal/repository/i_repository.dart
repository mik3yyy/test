import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/Aba/aba_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/Nuban/nuban_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/iban/iban_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_details_req/bank_details_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_details_res/bank_details_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/sepa/sepa_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/withdrawal_res.dart/withdrawal_res.dart';

abstract class IRepository {
  Future<BankRes> fetchBank();
  Future<BankDetailsRes> getBankDetails(
      GetBankAccountDetails getBankAccountDetails);
  Future<WithdrawRes> nubanWithdrawal(NubanReq nubanReq);
  Future<WithdrawRes> abaWithdrawal(AbaReq abaReq);
  Future<WithdrawRes> ibanWithdrawal(IbanReq ibanReq);
  Future<WithdrawRes> sepaWithdrawal(SepaReq sepaReq);
}
