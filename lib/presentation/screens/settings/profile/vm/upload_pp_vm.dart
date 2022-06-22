import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/profile/repo/profile_repository.dart';

final uploadProfilePicProvider =
    StateNotifierProvider<UploadPPVm, RequestState<CloudinaryResponse>>(
  (ref) => UploadPPVm(ref),
);

class UploadPPVm extends RequestStateNotifier<CloudinaryResponse> {
  final ProfileRepository _profileRepository;

  UploadPPVm(Ref ref) : _profileRepository = ref.read(profilehManagerProvider);

  Future<RequestState<CloudinaryResponse>> upLoadPP(filePath) =>
      makeRequest(() => _profileRepository.upLoadProfilePic(filePath));
}
