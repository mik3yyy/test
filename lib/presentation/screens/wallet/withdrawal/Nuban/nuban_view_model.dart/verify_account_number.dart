import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_details_req/bank_details_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_details_res/bank_details_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/repository/withdrawal_manager.dart';

class AccountNumNotifier extends StateNotifier<AsyncValue<BankDetailsRes>> {
  final Ref ref;
  AccountNumNotifier(this.ref)
      : super(AsyncValue.data(
            BankDetailsRes(data: Data(accountName: "", accountNumber: ""))));

  void getDetails(GetBankAccountDetails getBankAccountDetails) async {
    state = AsyncData(BankDetailsRes(data: Data()));
    state = const AsyncLoading();
    try {
      final details = await ref
          .read(withdrawManagerProvider)
          .getBankDetails(getBankAccountDetails);

      state = AsyncData(details);
    } catch (e) {
      state = AsyncError(e);
    }
  }
}

final accountDetailProvider =
    StateNotifierProvider<AccountNumNotifier, AsyncValue<BankDetailsRes>>(
        (ref) {
  return AccountNumNotifier(ref);
});
