import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/auth_manager.dart';

final remoteDebitStatement = FutureProvider((ref) {
  return ref.watch(authManagerProvider).statementOfAccount();
});

final debitStatement = FutureProvider((ref) {
  final debit = ref.watch(remoteDebitStatement).value;

  if (debit != null) {
    return debit.data.statements
        .where((element) => element.direction == "debit")
        .toList();
  } else {
    return [];
  }
});
