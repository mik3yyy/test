import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/messages/message_repository/message_manager.dart';

final downloadAttachmentProvider = StateNotifierProvider.autoDispose<
    DownloadAttachmentVM, RequestState<String>>((ref) {
  return DownloadAttachmentVM(ref);
});

class DownloadAttachmentVM extends RequestStateNotifier<String> {
  final MessageManager _messageManager;

  DownloadAttachmentVM(Ref ref)
      : _messageManager = ref.read(messageManagerProvider);

  void downloadAttachment(String filePath, String fileType) =>
      makeRequest(() => _messageManager.downloadAttachment(filePath, fileType));
}
