import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/profile/repo/profile_repository.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';

final getAllIdentification = FutureProvider.autoDispose((ref) {
  ref.keepAlive();
  ref.watch(userProfileProvider);
  return ref.watch(profilehManagerProvider).getID();
});
