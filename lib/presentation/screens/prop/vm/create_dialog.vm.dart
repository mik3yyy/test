import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/Dialog/create_dialog_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/messages/message_repository/message_manager.dart';

final createDialogProvider = StateNotifierProvider.autoDispose<CreateDialogVM,
    RequestState<CreateDialogRes>>((ref) {
  return CreateDialogVM(ref);
});

class CreateDialogVM extends RequestStateNotifier<CreateDialogRes> {
  final MessageManager _messageManager;

  CreateDialogVM(Ref ref) : _messageManager = ref.read(messageManagerProvider);

  void createDialog(int contactId, String message) =>
      makeRequest(() => _messageManager.createDialog(contactId, message));
}
