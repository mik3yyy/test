import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/statement_of_account/get_range_request.dart';
import 'package:kayndrexsphere_mobile/Data/model/statement_of_account/statement_of_account.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/auth_manager.dart';

class AccountRangeNotifier
    extends StateNotifier<RequestState<StatementOfAccount>> {
  final Ref ref;
  AccountRangeNotifier(this.ref) : super(const RequestState.idle());

  void getRange(StatementReq statementReq) async {
    try {
      state = const RequestState.loading();
      final range =
          await ref.read(authManagerProvider).getAccountRange(statementReq);
      state = RequestState<StatementOfAccount>.success(range);
    } catch (e, s) {
      state = RequestState.error(e, s);
      // throw e.toString();
    }
  }
}

final accountRangeProvider = StateNotifierProvider<AccountRangeNotifier,
    RequestState<StatementOfAccount>>((ref) {
  return AccountRangeNotifier(ref);
});
