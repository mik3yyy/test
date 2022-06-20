import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/req/change_password_req.dart';

import '../../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../../../Data/services/profile/repo/profile_repository.dart';

final changePasswordProvider =
    StateNotifierProvider<ChangePasswordVM, RequestState>(
  (ref) => ChangePasswordVM(ref),
);

class ChangePasswordVM extends RequestStateNotifier<bool> {
  final ProfileRepository _profileRepository;

  ChangePasswordVM(Ref ref)
      : _profileRepository = ref.read(profilehManagerProvider);

  void changePassword(ChangePasswordReq changePasswordReq) =>
      makeRequest(() => _profileRepository.changePassword(changePasswordReq));
}
