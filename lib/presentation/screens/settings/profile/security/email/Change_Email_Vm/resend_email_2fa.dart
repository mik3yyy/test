import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/new_sign_in_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/profile/repo/profile_repository.dart';

final resendEmail2FAProvider =
    StateNotifierProvider<ResendEmail2FAVm, RequestState<GenericRes>>(
  (ref) => ResendEmail2FAVm(ref),
);

class ResendEmail2FAVm extends RequestStateNotifier<GenericRes> {
  final ProfileRepository _profileRepository;

  ResendEmail2FAVm(Ref ref)
      : _profileRepository = ref.read(profilehManagerProvider);

  Future<RequestState<GenericRes>> resendEmail2FA(
    String email,
  ) =>
      makeRequest(() => _profileRepository.resendEmailChangeCode(email));
}
