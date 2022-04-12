import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/country_res.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../../Data/services/auth/manager/auth_manager.dart';

final getCountryProvider =
    StateNotifierProvider.autoDispose<GetCountryVm, RequestState<CountryRes>>(
  (ref) => GetCountryVm(ref),
);

class GetCountryVm extends RequestStateNotifier<CountryRes> {
  final AuthManager _authManager;

  GetCountryVm(Ref ref) : _authManager = ref.read(authManagerProvider) {
    getCountry();
  }

  void getCountry() => makeRequest(() => _authManager.getCountry());
}
