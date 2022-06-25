// To parse this JSON data, do
//
//     final signinReq = signinReqFromJson(jsonString);

import 'dart:convert';

SigninReq signinReqFromJson(String str) => SigninReq.fromJson(json.decode(str));

String signinReqToJson(SigninReq data) => json.encode(data.toJson());

class SigninReq {
  SigninReq({
    required this.emailPhone,
    required this.password,
    this.timezone,
    required this.deviceId,
  });

  String emailPhone;
  String password;
  String? timezone;
  String deviceId;

  factory SigninReq.fromJson(Map<String, dynamic> json) => SigninReq(
        emailPhone: json["email_phone"],
        password: json["password"],
        timezone: json["timezone"],
        deviceId: json["device_id"],
      );

  Map<String, dynamic> toJson() => {
        "email_phone": emailPhone,
        "password": password,
        "timezone": timezone,
        "device_id": deviceId,
      };
}
