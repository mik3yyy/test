// To parse this JSON data, do
//
//     final changePasswordReq = changePasswordReqFromJson(jsonString);

import 'dart:convert';

ChangePasswordReq changePasswordReqFromJson(String str) =>
    ChangePasswordReq.fromJson(json.decode(str));

String changePasswordReqToJson(ChangePasswordReq data) =>
    json.encode(data.toJson());

class ChangePasswordReq {
  ChangePasswordReq({
    this.oldPassword,
    this.newPassword,
    this.confirmPassword,
  });

  String? oldPassword;
  String? newPassword;
  String? confirmPassword;

  factory ChangePasswordReq.fromJson(Map<String, dynamic> json) =>
      ChangePasswordReq(
        oldPassword: json["old_password"],
        newPassword: json["new_password"],
        confirmPassword: json["confirm_password"],
      );

  Map<String, dynamic> toJson() => {
        "old_password": oldPassword,
        "new_password": newPassword,
        "confirm_password": confirmPassword,
      };
}
