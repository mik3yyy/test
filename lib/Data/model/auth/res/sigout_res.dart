// To parse this JSON data, do
//
//     final signinOutRes = signinOutResFromJson(jsonString);

import 'dart:convert';

SigninOutRes signinOutResFromJson(String str) =>
    SigninOutRes.fromJson(json.decode(str));

String signinOutResToJson(SigninOutRes data) => json.encode(data.toJson());

class SigninOutRes {
  SigninOutRes({
    this.message,
    this.status,
  });

  String? message;
  String? status;

  factory SigninOutRes.fromJson(Map<String, dynamic> json) => SigninOutRes(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
