import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_details_req/bank_details_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_details_res/bank_details_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/repository/withdrawal_manager.dart';

final getBankDetailsProvider = StateNotifierProvider.autoDispose<
    GetBankDetailsVM, RequestState<BankDetailsRes>>(
  (ref) => GetBankDetailsVM(ref),
);

class GetBankDetailsVM extends RequestStateNotifier<BankDetailsRes> {
  final WithdrawalManager withdrawalManager;

  GetBankDetailsVM(Ref ref)
      : withdrawalManager = ref.read(withdrawManagerProvider);

  void getDetails(GetBankAccountDetails getBankAccountDetails) => makeRequest(
      () => withdrawalManager.getBankDetails(getBankAccountDetails));
}
