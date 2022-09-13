import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/auth_manager.dart';

final remoteStatement = FutureProvider((ref) {
  return ref.watch(authManagerProvider).statementOfAccount();
});
