import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/profile/repo/profile_repository.dart';

final userProfileProvider = FutureProvider.autoDispose((ref) {
  ref.keepAlive();
  return ref.watch(profilehManagerProvider).getPrfileDetails();
});
