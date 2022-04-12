// To parse this JSON data, do
//
//     final resendOtp = resendOtpFromJson(jsonString);

import 'dart:convert';

ResendOtp resendOtpFromJson(String str) => ResendOtp.fromJson(json.decode(str));

String resendOtpToJson(ResendOtp data) => json.encode(data.toJson());

class ResendOtp {
  ResendOtp({
    this.emailPhone,
  });

  String? emailPhone;

  factory ResendOtp.fromJson(Map<String, dynamic> json) => ResendOtp(
        emailPhone: json["email_phone"],
      );

  Map<String, dynamic> toJson() => {
        "email_phone": emailPhone,
      };
}
