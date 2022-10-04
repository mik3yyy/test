import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/messages/message_repository/message_manager.dart';

final allContactsProvider = FutureProvider.autoDispose((ref) {
  return ref.watch(messageManagerProvider).getContacts();
});
