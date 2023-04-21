import 'package:kayndrexsphere_mobile/Data/model/Dialog/all_dialog.dart';
import 'package:kayndrexsphere_mobile/Data/model/Dialog/create_dialog_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/Dialog/dialog_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/new_sign_in_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/contact/contact_list.dart';
import 'package:kayndrexsphere_mobile/Data/model/contact/contact_res.dart';

abstract class MessageInterface {
  Future<ContactRes> createContact(String accountNumber);
  Future<ContactList> getContacts();
  Future<DialogRes> getDialogMessages(int id);
  Future<CreateDialogRes> createDialog(int contactId, String message);
  Future<GenericRes> sendMessage(int id, String message, String filePath);
  Future<AllDialog> getAllDialog();
  Future<GenericRes> renameContact(String contactName, int id);
  Future<GenericRes> deleteContact(int id);
  Future<GenericRes> blockContact(int id);
  Future<GenericRes> unblockContact(int id);
  Future<String> downloadAttachment(String url, String fileType);
}
