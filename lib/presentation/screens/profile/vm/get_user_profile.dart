import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/profile_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/profile/repo/profile_repository.dart';

final getUserProfileProvider =
    StateNotifierProvider<GetUserProfileVM, RequestState<ProfileRes>>(
  (ref) => GetUserProfileVM(ref),
);

class GetUserProfileVM extends RequestStateNotifier<ProfileRes> {
  final ProfileRepository _profileRepo;

  GetUserProfileVM(Ref ref) : _profileRepo = ref.read(profilehManagerProvider) {
    getUserProfile();
  }

  void getUserProfile() => makeRequest(() => _profileRepo.getPrfileDetails());
}
