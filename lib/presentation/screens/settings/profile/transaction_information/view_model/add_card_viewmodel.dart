import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/repository/card_service_manager.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/req/add_card.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/res/card_req.dart';

final addCardProvider =
    StateNotifierProvider.autoDispose<AddCardVM, RequestState<AddCardRes>>(
  (ref) => AddCardVM(ref),
);

class AddCardVM extends RequestStateNotifier<AddCardRes> {
  final CardServiceManager _cardServiceManager;

  AddCardVM(Ref ref)
      : _cardServiceManager = ref.read(cardServiceManagerProvider);

  void addCard(AddCard addCardreq) =>
      makeRequest(() => _cardServiceManager.addCard(addCardreq));
}
