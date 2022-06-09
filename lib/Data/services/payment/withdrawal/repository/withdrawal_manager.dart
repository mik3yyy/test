import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/Aba/aba_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/Nuban/nuban_beneficiaries.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/Nuban/nuban_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/beneficiary_accounts.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/iban/iban_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_details_res/bank_details_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_details_req/bank_details_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/repository/i_repository.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/sepa/sepa_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/withdrawal_res.dart/withdrawal_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/withdrawal_service.dart';

final withdrawManagerProvider = Provider((ref) {
  final withdrawService = ref.watch(withdrawServiceProvider);
  return WithdrawalManager(withdrawService);
});

class WithdrawalManager extends IRepository {
  final WithdrawalService withdrawalService;
  WithdrawalManager(this.withdrawalService);

  @override
  Future<BankRes> fetchBank() async {
    final bankres = await withdrawalService.fetchBank();
    return bankres;
  }

  @override
  Future<BankDetailsRes> getBankDetails(
      GetBankAccountDetails getBankAccountDetails) async {
    final bankDetails =
        await withdrawalService.getBankDetails(getBankAccountDetails);
    return bankDetails;
  }

  @override
  Future<WithdrawRes> nubanWithdrawal(NubanReq nubanReq) async {
    final nubanWithdrawal = await withdrawalService.nubanWithdrawal(nubanReq);
    return nubanWithdrawal;
  }

  @override
  Future<WithdrawRes> abaWithdrawal(AbaReq abaReq) async =>
      await withdrawalService.abaWithdrawal(abaReq);

  @override
  Future<WithdrawRes> ibanWithdrawal(IbanReq ibanReq) async =>
      await withdrawalService.ibanWithdrawal(ibanReq);

  @override
  Future<WithdrawRes> sepaWithdrawal(SepaReq sepaReq) async =>
      await withdrawalService.sepaWithdrawal(sepaReq);

  @override
  Future<BeneficiaryAccount> nubanBeneficiary() async =>
      await withdrawalService.nubanBeneficiary();

  @override
  Future<BeneficiaryAccount> abaBeneficiary() async =>
      await withdrawalService.abaBeneficiary();

  @override
  Future<BeneficiaryAccount> ibanBeneficiary() async =>
      await withdrawalService.ibanBeneficiary();
}
