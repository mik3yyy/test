import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/convert_currency_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/auth_manager.dart';

final conversionProvider =
    StateNotifierProvider<ConversionVM, RequestState<ConvertCurrencyRes>>(
  (ref) => ConversionVM(ref),
);

class ConversionVM extends RequestStateNotifier<ConvertCurrencyRes> {
  final AuthManager _authManager;

  ConversionVM(Ref ref) : _authManager = ref.read(authManagerProvider);

  void conversion(
    String from,
    String to,
  ) =>
      makeRequest(() => _authManager.convertCurrency(from, to));
}
