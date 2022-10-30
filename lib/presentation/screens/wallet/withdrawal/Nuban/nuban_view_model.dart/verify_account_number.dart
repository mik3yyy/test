import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_details_req/bank_details_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_details_res/bank_details_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/repository/withdrawal_manager.dart';

final accountDetailProvider = StateNotifierProvider.autoDispose<
    GetBankDetailsVM, RequestState<BankDetailsRes>>((ref) {
  return GetBankDetailsVM(ref);
});

class GetBankDetailsVM extends RequestStateNotifier<BankDetailsRes> {
  final Ref ref;

  GetBankDetailsVM(this.ref);

  Future<RequestState<BankDetailsRes>> getDetails(
      GetBankAccountDetails getBankAccountDetails) {
    return makeRequest(() => ref
        .read(withdrawManagerProvider)
        .getBankDetails(getBankAccountDetails));
  }
}
