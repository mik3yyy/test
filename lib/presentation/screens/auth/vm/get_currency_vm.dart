import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../../Data/model/auth/res/currency_res.dart';
import '../../../../Data/services/auth/manager/auth_manager.dart';

final getCurrencyProvider =
    StateNotifierProvider.autoDispose<GetCurrencyVm, RequestState<CurrencyRes>>(
        (ref) {
  ref.maintainState = true;
  return GetCurrencyVm(ref);
});

class GetCurrencyVm extends RequestStateNotifier<CurrencyRes> {
  final AuthManager _authManager;

  GetCurrencyVm(Ref ref) : _authManager = ref.read(authManagerProvider) {
    getCurrency();
  }

  void getCurrency() => makeRequest(() => _authManager.getCurrency());
}
