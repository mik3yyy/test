import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../../Data/services/auth/manager/auth_manager.dart';

final forgotPasswordProvider =
    StateNotifierProvider.autoDispose<ForgotPasswordVm, RequestState<bool>>(
        (ref) {
  final cancelToken = CancelToken();
  // When the provider is destroyed, cancel the http request
  ref.onDispose(() => cancelToken.cancel());
  return ForgotPasswordVm(ref, cancelToken);
});

class ForgotPasswordVm extends RequestStateNotifier<bool> {
  final Ref ref;
  final CancelToken cancelToken;

  ForgotPasswordVm(this.ref, this.cancelToken);

  Future<RequestState<bool>> forgotPassword(
    String emailPhone,
  ) =>
      makeRequest(() => ref
          .read(authManagerProvider)
          .forgotPassword(emailPhone, cancelToken));
}
