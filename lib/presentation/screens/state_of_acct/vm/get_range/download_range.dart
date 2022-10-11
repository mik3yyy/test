import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/statement_of_account/download_statement.dart';
import 'package:kayndrexsphere_mobile/Data/model/statement_of_account/get_range_request.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/auth_manager.dart';

class DownloadRangeNotifier
    extends StateNotifier<RequestState<DownloadStatement>> {
  final Ref ref;
  DownloadRangeNotifier(this.ref) : super(const RequestState.idle());

  void downloadRange(StatementReq statementReq) async {
    try {
      state = const RequestState.loading();
      final range =
          await ref.read(authManagerProvider).downloadRange(statementReq);
      state = RequestState<DownloadStatement>.success(range);
    } catch (e, s) {
      state = RequestState.error(e, s);
      // throw e.toString();
    }
  }
}

final downloadRangeProvider = StateNotifierProvider<DownloadRangeNotifier,
    RequestState<DownloadStatement>>((ref) {
  return DownloadRangeNotifier(ref);
});
