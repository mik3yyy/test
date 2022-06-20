import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/req/change_transactionpin_req.dart';

import '../../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../../../Data/services/profile/repo/profile_repository.dart';

final changeTransactionPinProvider =
    StateNotifierProvider<ChangeTransactionPinVM, RequestState>(
  (ref) => ChangeTransactionPinVM(ref),
);

class ChangeTransactionPinVM extends RequestStateNotifier<bool> {
  final ProfileRepository _profileRepository;

  ChangeTransactionPinVM(Ref ref)
      : _profileRepository = ref.read(profilehManagerProvider);

  void changeTransactionPin(ChangeTransactionPinReq changeTransactionPinReq) =>
      makeRequest(() =>
          _profileRepository.changeTransactionPin(changeTransactionPinReq));
}
