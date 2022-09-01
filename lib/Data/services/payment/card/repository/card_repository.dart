import 'package:kayndrexsphere_mobile/Data/services/payment/card/req/add_card_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/res/card_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/res/get_card.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/make_payment/fund_wallet/web_res.dart';

import '../../make_payment/fund_wallet/fund_wallet_req.dart';

abstract class CardRepository {
  Future<AddCardRes> addCard(AddCardReq addCardreq);
  Future<GetCardRes> getSavedCard();
  Future<StripeWebRes> fundWallet(FundWalletReq fundWalletReq);
  Future<AddCardRes> authorize(AddCardReq addCardReq);
}
