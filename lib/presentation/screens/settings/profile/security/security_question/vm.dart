import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/new_sign_in_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/security_question_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/profile/repo/profile_repository.dart';

final securityQuestionProvider =
    StateNotifierProvider<SecurityQuestionVm, RequestState<GenericRes>>(
  (ref) => SecurityQuestionVm(ref),
);

class SecurityQuestionVm extends RequestStateNotifier<GenericRes> {
  final ProfileRepository _profileRepository;

  SecurityQuestionVm(Ref ref)
      : _profileRepository = ref.read(profilehManagerProvider);

  Future<RequestState<GenericRes>> securityQuestion(
    SecurityQuesReq securityQuesReq,
  ) =>
      makeRequest(() => _profileRepository.securityQuestion(securityQuesReq));
}
