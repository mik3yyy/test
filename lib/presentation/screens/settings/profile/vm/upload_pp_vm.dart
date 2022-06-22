import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/profile/repo/profile_repository.dart';

// final uploadProfilePicProvider =
//     StateNotifierProvider<UploadPPVm, RequestState>(
//   (ref) => UploadPPVm(ref),
// );

// class UploadPPVm extends RequestStateNotifier {
//   final ProfileRepository _profileRepository;

//   UploadPPVm(Ref ref) : _profileRepository = ref.read(profilehManagerProvider);

//   Future<RequestState> upLoadPP(filePath) =>
//       makeRequest(() => _profileRepository.upLoadProfilePic(filePath));
// }

final userPhotoProvider =
    StateNotifierProvider<UserProfileVM, RequestState<bool>>(
  (ref) => UserProfileVM(ref),
);

class UserProfileVM extends RequestStateNotifier<bool> {
  final ProfileRepository _profileRepository;

  UserProfileVM(StateNotifierProviderRef ref)
      : _profileRepository = ref.read(profilehManagerProvider);

  uploadProfilePhoto(String path) =>
      makeRequest(() => _profileRepository.updateProfilePic(path: path));
}
