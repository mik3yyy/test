import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/auth_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';

final remoteStatement = FutureProvider.autoDispose((ref) {
  ref.maintainState = true;
  ref.watch(userProfileProvider);
  return ref.watch(authManagerProvider).statementOfAccount();
});
