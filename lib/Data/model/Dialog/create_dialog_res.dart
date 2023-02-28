// To parse this JSON data, do
//
//     final createDialogRes = createDialogResFromJson(jsonString);

import 'dart:convert';

CreateDialogRes createDialogResFromJson(String str) =>
    CreateDialogRes.fromJson(json.decode(str));

String createDialogResToJson(CreateDialogRes data) =>
    json.encode(data.toJson());

class CreateDialogRes {
  CreateDialogRes({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data data;

  factory CreateDialogRes.fromJson(Map<String, dynamic> json) =>
      CreateDialogRes(
        message: json["message"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.dialog,
    required this.title,
    this.img,
    required this.messages,
  });

  Dialog dialog;
  String title;
  dynamic img;
  List<Message> messages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        dialog: Dialog.fromJson(json["dialog"]),
        title: json["title"],
        img: json["img"],
        messages: List<Message>.from(
            json["messages"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dialog": dialog.toJson(),
        "title": title,
        "img": img,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
      };
}

class Dialog {
  Dialog({
    required this.isRoom,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  bool isRoom;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory Dialog.fromJson(Map<String, dynamic> json) => Dialog(
        isRoom: json["is_room"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "is_room": isRoom,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}

class Message {
  Message({
    required this.dialogId,
    required this.message,
    required this.ipAddress,
    required this.userAgent,
    required this.sentAt,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  int dialogId;
  String message;
  String ipAddress;
  String userAgent;
  DateTime sentAt;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        dialogId: json["dialog_id"],
        message: json["message"],
        ipAddress: json["ip_address"],
        userAgent: json["user_agent"],
        sentAt: DateTime.parse(json["sent_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "dialog_id": dialogId,
        "message": message,
        "ip_address": ipAddress,
        "user_agent": userAgent,
        "sent_at": sentAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
