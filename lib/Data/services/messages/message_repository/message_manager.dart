// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/Dialog/dialog_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/contact/contact_list.dart';
import 'package:kayndrexsphere_mobile/Data/model/contact/contact_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/messages/message_repository/meaage_interface.dart';
import 'package:kayndrexsphere_mobile/Data/services/messages/messages_service.dart';

final messageManagerProvider = Provider((ref) {
  return MessageManager(messageService: ref.watch(messageServiceProvider));
});

class MessageManager extends MessageInterface {
  final MessageService messageService;
  MessageManager({
    required this.messageService,
  });

  @override
  Future<ContactRes> createContact(String email) async =>
      await messageService.createContact(email);

  @override
  Future<ContactList> getContacts() async => await messageService.getContacts();

  @override
  Future<DialogRes> getDialogMessages(int id) async =>
      await messageService.getDialogMessages(id);
}
