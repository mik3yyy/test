import 'package:kayndrexsphere_mobile/Data/services/payment/card/req/add_card.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/res/card_req.dart';

abstract class CardRepository {
  Future<AddCardRes> addCard(AddCard addCardreq);
}
