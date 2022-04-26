import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../../Data/services/auth/manager/auth_manager.dart';

final transactionPinProvider =
    StateNotifierProvider<TransactionPinVm, RequestState<bool>>(
  (ref) => TransactionPinVm(ref),
);

class TransactionPinVm extends RequestStateNotifier<bool> {
  final AuthManager _authManager;

  TransactionPinVm(Ref ref) : _authManager = ref.read(authManagerProvider);

  Future<RequestState<bool>> transactionPin(
          String transactionPin, String confirmTransactionPin) =>
      makeRequest(() =>
          _authManager.transactionPin(transactionPin, confirmTransactionPin));
}
