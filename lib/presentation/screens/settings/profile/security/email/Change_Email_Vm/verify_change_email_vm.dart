import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/new_sign_in_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/profile/repo/profile_repository.dart';

final verifyEmailChangeProvider =
    StateNotifierProvider<VerifyEmailChangeVm, RequestState<GenericRes>>(
  (ref) => VerifyEmailChangeVm(ref),
);

class VerifyEmailChangeVm extends RequestStateNotifier<GenericRes> {
  final ProfileRepository _profileRepository;

  VerifyEmailChangeVm(Ref ref)
      : _profileRepository = ref.read(profilehManagerProvider);

  Future<RequestState<GenericRes>> changeEmail(
    String code,
  ) =>
      makeRequest(() => _profileRepository.verifyChangeEmail2FA(code));
}
