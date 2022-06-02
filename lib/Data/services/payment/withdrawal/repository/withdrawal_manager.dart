import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_details_res/bank_details_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_details_req/bank_details_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/repository/i_repository.dart';
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
}
