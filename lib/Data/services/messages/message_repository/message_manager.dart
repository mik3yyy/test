// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/Dialog/all_dialog.dart';
import 'package:kayndrexsphere_mobile/Data/model/Dialog/create_dialog_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/Dialog/dialog_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/new_sign_in_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/contact/contact_list.dart';
import 'package:kayndrexsphere_mobile/Data/model/contact/contact_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/messages/message_repository/message_interface.dart';
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

  @override
  Future<CreateDialogRes> createDialog(String email, String message) async =>
      await messageService.createDialog(email, message);

  @override
  Future<GenericRes> sendMessage(
          int id, String message, String filePath) async =>
      await messageService.sendMessage(id, message, filePath);

  @override
  Future<AllDialog> getAllDialog() async => await messageService.getAllDialog();

  @override
  Future<GenericRes> blockContact(int id) async =>
      await messageService.blockContact(id);

  @override
  Future<GenericRes> deleteContact(int id) async =>
      await messageService.deleteContact(id);

  @override
  Future<GenericRes> renameContact(String contactName, int id) async =>
      await messageService.renameContact(contactName, id);

  @override
  Future<GenericRes> unblockContact(int id) async =>
      await messageService.unblockContact(id);

  @override
  Future<String> downloadAttachment(String url, String fileType) async =>
      await messageService.downloadAttachment(url, fileType);
}
