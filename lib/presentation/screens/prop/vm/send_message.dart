import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/new_sign_in_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/messages/message_repository/message_manager.dart';

final sendMessageProvider =
    StateNotifierProvider.autoDispose<SendMessageVM, RequestState<GenericRes>>(
        (ref) {
  return SendMessageVM(ref);
});

class SendMessageVM extends RequestStateNotifier<GenericRes> {
  final MessageManager _messageManager;

  SendMessageVM(Ref ref) : _messageManager = ref.read(messageManagerProvider);

  void sendMessage(int id, String message) =>
      makeRequest(() => _messageManager.sendMessage(id, message));
}
