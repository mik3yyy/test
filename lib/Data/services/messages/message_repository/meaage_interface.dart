import 'package:kayndrexsphere_mobile/Data/model/Dialog/dialog_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/contact/contact_list.dart';
import 'package:kayndrexsphere_mobile/Data/model/contact/contact_res.dart';

abstract class MessageInterface {
  Future<ContactRes> createContact(String email);
  Future<ContactList> getContacts();
  Future<DialogRes> getDialogMessages(int id);
}
