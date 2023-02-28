import 'package:kayndrexsphere_mobile/Data/model/Dialog/all_dialog.dart';
import 'package:kayndrexsphere_mobile/Data/model/Dialog/create_dialog_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/Dialog/dialog_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/new_sign_in_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/contact/contact_list.dart';
import 'package:kayndrexsphere_mobile/Data/model/contact/contact_res.dart';

abstract class MessageInterface {
  Future<ContactRes> createContact(String email);
  Future<ContactList> getContacts();
  Future<DialogRes> getDialogMessages(int id);
  Future<CreateDialogRes> createDialog(String email, String message);
  Future<GenericRes> sendMessage(int id, String message);
  Future<AllDialog> getAllDialog();
}
