import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/repository/card_service_manager.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/make_payment/fund_wallet/fund_wallet_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/make_payment/fund_wallet/web_res.dart';

final fundWalletProvider =
    StateNotifierProvider.autoDispose<FundWallet, RequestState<StripeWebRes>>(
  (ref) => FundWallet(ref),
);

class FundWallet extends RequestStateNotifier<StripeWebRes> {
  final CardServiceManager _cardServiceManager;

  FundWallet(Ref ref)
      : _cardServiceManager = ref.read(cardServiceManagerProvider);

  void fundWallet(FundWalletReq fundWalletReq) =>
      makeRequest(() => _cardServiceManager.fundWallet(fundWalletReq));
}
