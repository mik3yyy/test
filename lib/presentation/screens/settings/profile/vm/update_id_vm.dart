import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/profile/repo/profile_repository.dart';

import '../../../../../Data/controller/controller/generic_state_notifier.dart';

final userIdProvider = StateNotifierProvider<UserIdVM, RequestState<bool>>(
  (ref) => UserIdVM(ref),
);

class UserIdVM extends RequestStateNotifier<bool> {
  final ProfileRepository _profileRepository;

  UserIdVM(StateNotifierProviderRef ref)
      : _profileRepository = ref.read(profilehManagerProvider);

  uploadId(String filePath, String idType, String idNo) =>
      makeRequest(() => _profileRepository.updateId(filePath, idType, idNo));
}
