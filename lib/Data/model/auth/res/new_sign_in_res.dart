// To parse this JSON data, do
//
//     final failure = failureFromJson(jsonString);

import 'dart:convert';

LoginRes loginResFromJson(String str) => LoginRes.fromJson(json.decode(str));

String loginResToJson(LoginRes data) => json.encode(data.toJson());

class LoginRes {
  LoginRes({
    this.message,
    this.status,
  });

  String? message;
  String? status;

  factory LoginRes.fromJson(Map<String, dynamic> json) => LoginRes(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
