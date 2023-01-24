// To parse this JSON data, do
//
//     final resetEmailReq = resetEmailReqFromJson(jsonString);

import 'dart:convert';

String resetEmailReqToJson(ResetEmailReq data) => json.encode(data.toJson());

class ResetEmailReq {
  ResetEmailReq({
    required this.code,
    required this.newEmail,
    required this.the2FaToken,
  });

  String code;
  String newEmail;
  String the2FaToken;

  Map<String, dynamic> toJson() => {
        "code": code,
        "new_email": newEmail,
        "2fa_token": the2FaToken,
      };
}
