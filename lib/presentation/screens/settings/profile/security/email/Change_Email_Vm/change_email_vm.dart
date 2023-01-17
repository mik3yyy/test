import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/new_sign_in_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/req/change_email_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/profile/repo/profile_repository.dart';

final changeEmailProvider =
    StateNotifierProvider<ChangeEmailVm, RequestState<GenericRes>>(
  (ref) => ChangeEmailVm(ref),
);

class ChangeEmailVm extends RequestStateNotifier<GenericRes> {
  final ProfileRepository _profileRepository;

  ChangeEmailVm(Ref ref)
      : _profileRepository = ref.read(profilehManagerProvider);

  Future<RequestState<GenericRes>> changeEmail(
    ChangeEmailReq changeEmailReq,
  ) =>
      makeRequest(() => _profileRepository.changeEmail(changeEmailReq));
}
