// To parse this JSON data, do
//
//     final changeEmailReq = changeEmailReqFromJson(jsonString);

import 'dart:convert';

String changeEmailReqToJson(ChangeEmailReq? data) =>
    json.encode(data!.toJson());

class ChangeEmailReq {
  ChangeEmailReq({
    this.oldEmail,
    this.newEmail,
    this.password,
  });

  String? oldEmail;
  String? newEmail;
  String? password;

  Map<String, dynamic> toJson() => {
        "old_email": oldEmail,
        "new_email": newEmail,
        "password": password,
      };
}
