// To parse this JSON data, do
//
//     final withdrawRes = withdrawResFromJson(jsonString);

import 'dart:convert';

WithdrawRes withdrawResFromJson(String str) =>
    WithdrawRes.fromJson(json.decode(str));

String withdrawResToJson(WithdrawRes data) => json.encode(data.toJson());

class WithdrawRes {
  WithdrawRes({
    this.message,
    this.status,
  });

  String? message;
  String? status;

  factory WithdrawRes.fromJson(Map<String, dynamic> json) => WithdrawRes(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
