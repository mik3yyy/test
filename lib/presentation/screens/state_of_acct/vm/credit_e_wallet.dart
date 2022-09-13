import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/state_of_acct/vm/e_wallet_vm.dart';

// final remoteCreditStatement = FutureProvider.autoDispose((ref) {
//   ref.maintainState = true;
//   return ref.watch(authManagerProvider).statementOfAccount();
// });

final creditStatement = FutureProvider.autoDispose((ref) {
  final credit = ref.watch(remoteStatement).value;
  // final statement = ref.watch(remoteStatement).value;

  if (credit != null) {
    return credit.data.statements
        .where((element) => element.direction == "credit")
        .toList();
  } else {
    return [];
  }
});
