import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/repository/card_service_manager.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/res/get_card.dart';

final getCardProvider =
    StateNotifierProvider.autoDispose<GetCardVM, RequestState<GetCardRes>>(
  (ref) => GetCardVM(ref),
);

class GetCardVM extends RequestStateNotifier<GetCardRes> {
  final CardServiceManager _cardServiceManager;

  GetCardVM(Ref ref)
      : _cardServiceManager = ref.read(cardServiceManagerProvider) {
    getCard();
  }

  void getCard() => makeRequest(() => _cardServiceManager.getSavedCard());
}
