import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/Aba/aba_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/repository/withdrawal_manager.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/withdrawal_res.dart/withdrawal_res.dart';

final abaWithdrawalProvider = StateNotifierProvider.autoDispose<AbaWithdrawalVM,
    RequestState<WithdrawRes>>(
  (ref) => AbaWithdrawalVM(ref),
);

class AbaWithdrawalVM extends RequestStateNotifier<WithdrawRes> {
  final WithdrawalManager withdrawalManager;

  AbaWithdrawalVM(Ref ref)
      : withdrawalManager = ref.read(withdrawManagerProvider);

  void abaWithdrawal(AbaReq abaReq) =>
      makeRequest(() => withdrawalManager.abaWithdrawal(abaReq));
}
