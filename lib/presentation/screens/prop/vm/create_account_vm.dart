import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/contact/contact_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/messages/message_repository/message_manager.dart';

final addContactProvider = StateNotifierProvider.autoDispose<CreateContactVM,
    RequestState<ContactRes>>((ref) {
  return CreateContactVM(ref);
});

class CreateContactVM extends RequestStateNotifier<ContactRes> {
  final MessageManager _messageManager;

  CreateContactVM(Ref ref) : _messageManager = ref.read(messageManagerProvider);

  void addContact(String email) =>
      makeRequest(() => _messageManager.createContact(email));
}
