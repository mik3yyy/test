import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/profile_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/profile/repo/profile_repository.dart';

import '../../../../../Data/controller/controller/generic_state_notifier.dart';

final getProfileProvider =
    StateNotifierProvider<GetProfileVM, RequestState<ProfileRes>>(
  (ref) => GetProfileVM(ref),
);

class GetProfileVM extends RequestStateNotifier<ProfileRes> {
  final ProfileRepository _profileRepository;

  GetProfileVM(Ref ref)
      : _profileRepository = ref.read(profilehManagerProvider) {
    getProfile();
  }

  Future<RequestState<ProfileRes>> getProfile() =>
      makeRequest(() => _profileRepository.getPrfileDetails());
}
