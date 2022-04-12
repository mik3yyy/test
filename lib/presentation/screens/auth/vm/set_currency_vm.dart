import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/auth_manager.dart';

final setCurrencyProvider =
    StateNotifierProvider<SetCurrencyVm, RequestState<bool>>(
  (ref) => SetCurrencyVm(ref),
);

class SetCurrencyVm extends RequestStateNotifier<bool> {
  final AuthManager _authManager;

  SetCurrencyVm(Ref ref) : _authManager = ref.read(authManagerProvider);

  Future<RequestState<bool>> setCurrency(
    String currency,
    String language,
    String country,
  ) =>
      makeRequest(() => _authManager.setCurrency(currency, language, country));
}
