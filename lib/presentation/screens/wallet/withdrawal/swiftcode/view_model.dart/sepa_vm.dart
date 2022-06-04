import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/repository/withdrawal_manager.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/sepa/sepa_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/withdrawal_res.dart/withdrawal_res.dart';

final sepaWithdrawalProvider = StateNotifierProvider.autoDispose<
    IbanWithdrawalVM, RequestState<WithdrawRes>>(
  (ref) => IbanWithdrawalVM(ref),
);

class IbanWithdrawalVM extends RequestStateNotifier<WithdrawRes> {
  final WithdrawalManager withdrawalManager;

  IbanWithdrawalVM(Ref ref)
      : withdrawalManager = ref.read(withdrawManagerProvider);

  void sepaWithdrawal(SepaReq sepaReq) =>
      makeRequest(() => withdrawalManager.sepaWithdrawal(sepaReq));
}
