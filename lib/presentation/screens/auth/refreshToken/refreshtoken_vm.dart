import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/refreshToken/refresh_token_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/refreshToken/refresh_token_res.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../../Data/services/auth/manager/auth_manager.dart';

final refreshTokenProvider = StateNotifierProvider.autoDispose<RefreshTokenVM,
    RequestState<RefreshTokenRes>>(
  (ref) => RefreshTokenVM(ref),
);

class RefreshTokenVM extends RequestStateNotifier<RefreshTokenRes> {
  final AuthManager _authManager;

  RefreshTokenVM(Ref ref) : _authManager = ref.read(authManagerProvider);

  void getCountry(RefreshTokenReq refreshTokenReq) =>
      makeRequest(() => _authManager.getAuthTOken(refreshTokenReq));
}
