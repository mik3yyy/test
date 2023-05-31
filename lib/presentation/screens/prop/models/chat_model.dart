import 'package:kayndrexsphere_mobile/Data/model/Dialog/dialog_res.dart';

class ChatModel {
  int id;
  int dialogId;
  String message;
  DateTime sentAt;
  String firstName;
  String lastName;
  String email;
  final List<Attachment>? attachments;

  ChatModel({
    required this.id,
    required this.dialogId,
    required this.message,
    required this.sentAt,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.attachments,
  });
}
