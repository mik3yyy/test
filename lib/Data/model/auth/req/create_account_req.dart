// To parse this JSON data, do
//
//     final createAccount = createAccountFromJson(jsonString);

import 'dart:convert';

CreateAccount createAccountFromJson(String str) =>
    CreateAccount.fromJson(json.decode(str));

String createAccountToJson(CreateAccount data) => json.encode(data.toJson());

class CreateAccount {
  CreateAccount({
    this.firstName,
    this.lastName,
    this.emailPhone,
  });

  String? firstName;
  String? lastName;
  String? emailPhone;

  factory CreateAccount.fromJson(Map<String, dynamic> json) => CreateAccount(
        firstName: json["first_name"],
        lastName: json["last_name"],
        emailPhone: json["email_phone"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email_phone": emailPhone,
      };
}
