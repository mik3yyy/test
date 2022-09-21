// To parse this JSON data, do
//
//     final deactivateAccountRes = deactivateAccountResFromJson(jsonString);

import 'dart:convert';

DeactivateAccountRes deactivateAccountResFromJson(String str) =>
    DeactivateAccountRes.fromJson(json.decode(str));

String deactivateAccountResToJson(DeactivateAccountRes data) =>
    json.encode(data.toJson());

class DeactivateAccountRes {
  DeactivateAccountRes({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  String? status;
  dynamic data;

  factory DeactivateAccountRes.fromJson(Map<String, dynamic> json) =>
      DeactivateAccountRes(
        message: json["message"],
        status: json["status"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data,
      };
}
