import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/iban/iban_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/repository/withdrawal_manager.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/withdrawal_res.dart/withdrawal_res.dart';

final ibanWithdrawalProvider = StateNotifierProvider.autoDispose<
    IbanWithdrawalVM, RequestState<WithdrawRes>>(
  (ref) => IbanWithdrawalVM(ref),
);

class IbanWithdrawalVM extends RequestStateNotifier<WithdrawRes> {
  final WithdrawalManager withdrawalManager;

  IbanWithdrawalVM(Ref ref)
      : withdrawalManager = ref.read(withdrawManagerProvider);

  void ibanWithdrawal(IbanReq ibanReq) =>
      makeRequest(() => withdrawalManager.ibanWithdrawal(ibanReq));
}
