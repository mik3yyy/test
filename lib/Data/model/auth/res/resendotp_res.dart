// To parse this JSON data, do
//
//     final resendOtpRes = resendOtpResFromJson(jsonString);

import 'dart:convert';

ResendOtpRes resendOtpResFromJson(String str) =>
    ResendOtpRes.fromJson(json.decode(str));

String resendOtpResToJson(ResendOtpRes data) => json.encode(data.toJson());

class ResendOtpRes {
  ResendOtpRes({
    this.message,
    this.status,
  });

  String? message;
  String? status;

  factory ResendOtpRes.fromJson(Map<String, dynamic> json) => ResendOtpRes(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
