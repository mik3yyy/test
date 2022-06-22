import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/profile/repo/profile_repository.dart';

final uploadImageProvider =
    StateNotifierProvider<UploadImageVm, RequestState<bool>>(
  (ref) => UploadImageVm(ref),
);

class UploadImageVm extends RequestStateNotifier<bool> {
  final ProfileRepository _profileRepository;

  UploadImageVm(Ref ref)
      : _profileRepository = ref.read(profilehManagerProvider);

  Future<RequestState<bool>> upLoadImage(imageUrl) =>
      makeRequest(() => _profileRepository.uploadPP(imageUrl));
}
