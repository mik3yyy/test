import 'package:kayndrexsphere_mobile/Data/services/payment/card/req/add_card.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/res/card_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/res/get_card.dart';

import '../../make_payment/fund_wallet/fund_wallet_req.dart';
import '../../make_payment/fund_wallet/fund_wallet_res.dart';

abstract class CardRepository {
  Future<AddCardRes> addCard(AddCard addCardreq);
  Future<GetCardRes> getSavedCard();
  Future<FundWalletRes> fundWallet(FundWalletReq fundWalletReq);
}
