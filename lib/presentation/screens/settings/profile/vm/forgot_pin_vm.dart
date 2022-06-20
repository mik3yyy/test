import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/profile/repo/profile_repository.dart';

final forgotPinProvider =
    StateNotifierProvider<ForgotPinVm, RequestState<bool>>(
  (ref) => ForgotPinVm(ref),
);

class ForgotPinVm extends RequestStateNotifier<bool> {
  final ProfileRepository _profileRepository;

  ForgotPinVm(Ref ref) : _profileRepository = ref.read(profilehManagerProvider);

  Future<RequestState<bool>> forgotPin(
    String emailPhone,
  ) =>
      makeRequest(() => _profileRepository.forgotPin(emailPhone));
}
