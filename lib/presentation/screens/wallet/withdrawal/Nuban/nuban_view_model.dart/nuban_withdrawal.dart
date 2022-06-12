import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/Nuban/nuban_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/repository/withdrawal_manager.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/withdrawal_res.dart/withdrawal_res.dart';

final nubanWithdrawalProvider = StateNotifierProvider.autoDispose<
    NubanWithdrawalVM, RequestState<WithdrawRes>>(
  (ref) => NubanWithdrawalVM(ref),
);

class NubanWithdrawalVM extends RequestStateNotifier<WithdrawRes> {
  final WithdrawalManager withdrawalManager;

  NubanWithdrawalVM(Ref ref)
      : withdrawalManager = ref.read(withdrawManagerProvider);

  Future<RequestState<WithdrawRes>> nubanWithdrawal(NubanReq nubanReq) =>
      makeRequest(() => withdrawalManager.nubanWithdrawal(nubanReq));
}
