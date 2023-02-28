import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/Dialog/dialog_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/messages/message_repository/message_manager.dart';

final alldialogMessages =
    FutureProvider.autoDispose.family<DialogRes, int>((ref, id) async {
  final messages =
      await ref.watch(messageManagerProvider).getDialogMessages(id);
  // ref.read(pusherProvider).initialize(messages.data!.dialog!.uuid.toString());
  return messages;
});

final alldialogsProvider = FutureProvider.autoDispose((ref) async {
  return ref.watch(messageManagerProvider).getAllDialog();
});
