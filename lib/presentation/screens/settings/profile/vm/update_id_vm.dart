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

///EDIT SAVED ID PROVIDER
final editIdProvider =
    StateNotifierProvider<EditIDVM, RequestState<UploadIdRes>>(
  (ref) => EditIDVM(ref),
);

class EditIDVM extends RequestStateNotifier<UploadIdRes> {
  final ProfileRepository _profileRepository;

  EditIDVM(StateNotifierProviderRef ref)
      : _profileRepository = ref.read(profilehManagerProvider);

  void editID(
          {required String filePath,
          required String idType,
          required String idNo,
          required bool isEdit,
          required String id}) =>
      makeRequest(
          () => _profileRepository.editId(filePath, idType, idNo, id, isEdit));
}

///DELETE SAVED ID PROVIDER
final deleteIdProvider =
    StateNotifierProvider<DeleteIDVM, RequestState<UploadIdRes>>(
  (ref) => DeleteIDVM(ref),
);

class DeleteIDVM extends RequestStateNotifier<UploadIdRes> {
  final ProfileRepository _profileRepository;

  DeleteIDVM(StateNotifierProviderRef ref)
      : _profileRepository = ref.read(profilehManagerProvider);

  void deleteID({required String id}) =>
      makeRequest(() => _profileRepository.deleteId(id));
}
