class ChatModel {
  int id;
  int dialogId;
  String message;
  DateTime sentAt;
  String firstName;
  String lastName;
  String email;

  ChatModel({
    required this.id,
    required this.dialogId,
    required this.message,
    required this.sentAt,
    required this.firstName,
    required this.lastName,
    required this.email,
  });
}
