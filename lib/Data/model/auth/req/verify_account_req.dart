// To parse this JSON data, do
//
//     final verifyAccount = verifyAccountFromJson(jsonString);

import 'dart:convert';

VerifyAccount verifyAccountFromJson(String str) =>
    VerifyAccount.fromJson(json.decode(str));

String verifyAccountToJson(VerifyAccount data) => json.encode(data.toJson());

class VerifyAccount {
  VerifyAccount({
    this.verificationCode,
    this.emailPhone,
  });

  String? verificationCode;
  String? emailPhone;

  factory VerifyAccount.fromJson(Map<String, dynamic> json) => VerifyAccount(
        verificationCode: json["verification_code"],
        emailPhone: json["email_phone"],
      );

  Map<String, dynamic> toJson() => {
        "verification_code": verificationCode,
        "email_phone": emailPhone,
      };
}
