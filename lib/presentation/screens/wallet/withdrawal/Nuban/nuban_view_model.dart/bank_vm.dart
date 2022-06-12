import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/repository/withdrawal_manager.dart';

final getBankProvider = StateNotifierProvider<GetBankVM, RequestState<BankRes>>(
  (ref) => GetBankVM(ref),
);

class GetBankVM extends RequestStateNotifier<BankRes> {
  final WithdrawalManager withdrawalManager;

  GetBankVM(Ref ref) : withdrawalManager = ref.read(withdrawManagerProvider) {
    getbank();
  }

  Future<RequestState<BankRes>> getbank() =>
      makeRequest(() => withdrawalManager.fetchBank());
}
