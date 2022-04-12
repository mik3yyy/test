// To parse this JSON data, do
//
//     final createPassword = createPasswordFromJson(jsonString);

import 'dart:convert';

CreatePassword createPasswordFromJson(String str) =>
    CreatePassword.fromJson(json.decode(str));

String createPasswordToJson(CreatePassword data) => json.encode(data.toJson());

class CreatePassword {
  CreatePassword({
    this.password,
    this.confirmPassword,
  });

  String? password;
  String? confirmPassword;

  factory CreatePassword.fromJson(Map<String, dynamic> json) => CreatePassword(
        password: json["password"],
        confirmPassword: json["confirm_password"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "confirm_password": confirmPassword,
      };
}
