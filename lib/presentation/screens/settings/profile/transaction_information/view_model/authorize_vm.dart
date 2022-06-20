import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/repository/card_service_manager.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/req/add_card_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/res/card_res.dart';

final authorizeProvider =
    StateNotifierProvider.autoDispose<AuthorizeVM, RequestState<AddCardRes>>(
  (ref) => AuthorizeVM(ref),
);

class AuthorizeVM extends RequestStateNotifier<AddCardRes> {
  final CardServiceManager _cardServiceManager;

  AuthorizeVM(Ref ref)
      : _cardServiceManager = ref.read(cardServiceManagerProvider);

  void authorize(AddCardReq addCardreq) =>
      makeRequest(() => _cardServiceManager.authorize(addCardreq));
}
