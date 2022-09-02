import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/card_service/card_service.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/repository/card_repository.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/res/card_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/req/add_card_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/res/get_card.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/make_payment/fund_wallet/fund_wallet_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/make_payment/fund_wallet/web_res.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';

final cardServiceManagerProvider = Provider((ref) {
  final cardService = ref.watch(cardServiceProvider);
  return CardServiceManager(cardService);
});

class CardServiceManager extends CardRepository {
  final CardService _cardService;
  CardServiceManager(this._cardService);

  @override
  Future<AddCardRes> addCard(AddCardReq addCardreq) async {
    final res = await _cardService.addCard(addCardreq);
    PreferenceManager.depositRef = res.data!.depositRef!;
    return res;
  }

  @override
  Future<GetCardRes> getSavedCard() async => await _cardService.getSavedCard();

  @override
  Future<StripeWebRes> fundWallet(FundWalletReq fundWalletReq) async =>
      await _cardService.fundWallet(fundWalletReq);

  @override
  Future<AddCardRes> authorize(AddCardReq addCardReq) async =>
      await _cardService.authorize(addCardReq);
}
