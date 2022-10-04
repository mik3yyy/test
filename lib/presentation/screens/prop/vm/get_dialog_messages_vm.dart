import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/Dialog/dialog_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/messages/message_repository/message_manager.dart';

final alldialogMessages = FutureProvider.family<DialogRes, int>((ref, id) {
  return ref.watch(messageManagerProvider).getDialogMessages(id);
});
