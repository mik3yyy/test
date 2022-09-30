// To parse this JSON data, do
//
//     final uploadIdRes = uploadIdResFromJson(jsonString);

import 'dart:convert';

UploadIdRes uploadIdResFromJson(String str) =>
    UploadIdRes.fromJson(json.decode(str));

String uploadIdResToJson(UploadIdRes data) => json.encode(data.toJson());

class UploadIdRes {
  UploadIdRes({
    this.message,
    this.status,
  });

  String? message;
  String? status;

  factory UploadIdRes.fromJson(Map<String, dynamic> json) => UploadIdRes(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
