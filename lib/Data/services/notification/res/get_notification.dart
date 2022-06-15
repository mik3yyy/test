// To parse this JSON data, do
//
//     final getNotification = getNotificationFromJson(jsonString);

import 'dart:convert';

GetNotification getNotificationFromJson(String str) =>
    GetNotification.fromJson(json.decode(str));

String getNotificationToJson(GetNotification data) =>
    json.encode(data.toJson());

class GetNotification {
  GetNotification({
    this.message,
    this.status,
    required this.data,
  });

  String? message;
  String? status;
  GetNotificationData data;

  factory GetNotification.fromJson(Map<String, dynamic> json) =>
      GetNotification(
        message: json["message"],
        status: json["status"],
        data: GetNotificationData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data.toJson(),
      };
}

class GetNotificationData {
  GetNotificationData({
    required this.notifications,
  });

  List<Notification> notifications;

  factory GetNotificationData.fromJson(Map<String, dynamic> json) =>
      GetNotificationData(
        notifications: List<Notification>.from(
            json["notifications"].map((x) => Notification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "notifications":
            List<dynamic>.from(notifications.map((x) => x.toJson())),
      };
}

class Notification {
  Notification({
    this.id,
    this.data,
    this.createdAt,
    this.updatedAt,
    this.readAt,
    this.timeAgo,
  });

  String? id;
  NotificationData? data;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic readAt;
  String? timeAgo;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        data: NotificationData.fromJson(json["data"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        readAt: json["read_at"],
        timeAgo: json["time_ago"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "data": data!.toJson(),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "read_at": readAt,
        "time_ago": timeAgo,
      };
}

class NotificationData {
  NotificationData({
    this.message,
    this.summary,
  });

  String? message;
  String? summary;

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        message: json["message"],
        summary: json["summary"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "summary": summary,
      };
}
