import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/profile/repo/profile_repository.dart';

final resetPinProvider = StateNotifierProvider<ResetPinVm, RequestState<bool>>(
  (ref) => ResetPinVm(ref),
);

class ResetPinVm extends RequestStateNotifier<bool> {
  final ProfileRepository _profileRepository;

  ResetPinVm(Ref ref) : _profileRepository = ref.read(profilehManagerProvider);

  Future<RequestState<bool>> resetPin(
    String otpCode,
    String pin,
    String confirmPin,
  ) =>
      makeRequest(() => _profileRepository.resetPin(otpCode, pin, confirmPin));
}
