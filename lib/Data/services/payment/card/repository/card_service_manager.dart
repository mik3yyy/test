import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/card_service/card_service.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/repository/card_repository.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/res/card_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/req/add_card.dart';

final cardServiceManagerProvider = Provider((ref) {
  final cardService = ref.watch(cardServiceProvider);
  return CardServiceManager(cardService);
});

class CardServiceManager extends CardRepository {
  final CardService _cardService;
  CardServiceManager(this._cardService);

  @override
  Future<AddCardRes> addCard(AddCard addCardreq) async =>
      await _cardService.addCard(addCardreq);
}
