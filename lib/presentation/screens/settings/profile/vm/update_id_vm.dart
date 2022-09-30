import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/upload_id_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/profile/repo/profile_repository.dart';

import '../../../../../Data/controller/controller/generic_state_notifier.dart';

final userIdProvider =
    StateNotifierProvider<UserIdVM, RequestState<UploadIdRes>>(
  (ref) => UserIdVM(ref),
);

class UserIdVM extends RequestStateNotifier<UploadIdRes> {
  final ProfileRepository _profileRepository;

  UserIdVM(StateNotifierProviderRef ref)
      : _profileRepository = ref.read(profilehManagerProvider);

  uploadId(String filePath, String idType, String idNo) =>
      makeRequest(() => _profileRepository.updateId(filePath, idType, idNo));
}
