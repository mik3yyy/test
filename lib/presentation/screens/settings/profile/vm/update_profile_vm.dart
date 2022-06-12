import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/req/update_profile_req.dart';

import '../../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../../../Data/services/profile/repo/profile_repository.dart';

final updateProfileProvider =
    StateNotifierProvider<UpdateProfileVM, RequestState>(
  (ref) => UpdateProfileVM(ref),
);

class UpdateProfileVM extends RequestStateNotifier<bool> {
  final ProfileRepository _profileRepository;

  UpdateProfileVM(Ref ref)
      : _profileRepository = ref.read(profilehManagerProvider);

  void updateProfile(UpdateProfileReq updateProfileReq) =>
      makeRequest(() => _profileRepository.updatePrfileDetails(
          updateProfileReq: updateProfileReq));
}
