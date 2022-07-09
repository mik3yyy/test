import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/repository/card_service_manager.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/res/get_card.dart';

import '../../../../../Data/controller/controller/generic_state_notifier.dart';

final getSavedCardProvider =
    StateNotifierProvider<GetSavedCardsVM, RequestState<GetCardRes>>(
  (ref) => GetSavedCardsVM(ref),
);

class GetSavedCardsVM extends RequestStateNotifier<GetCardRes> {
  final CardServiceManager _cardServiceManager;

  GetSavedCardsVM(Ref ref)
      : _cardServiceManager = ref.read(cardServiceManagerProvider) {
    getCard();
  }

  void getCard() => makeRequest(() => _cardServiceManager.getSavedCard());
}
