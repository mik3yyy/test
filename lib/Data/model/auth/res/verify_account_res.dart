// To parse this JSON data, do
//
//     final verifyRes = verifyResFromJson(jsonString);

import 'dart:convert';

VerifyRes verifyResFromJson(String str) => VerifyRes.fromJson(json.decode(str));

String verifyResToJson(VerifyRes data) => json.encode(data.toJson());

class VerifyRes {
  VerifyRes({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  String? status;
  Data? data;

  factory VerifyRes.fromJson(Map<String, dynamic> json) => VerifyRes(
        message: json["message"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.pseudoToken,
  });

  String? pseudoToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pseudoToken: json["pseudo_token"],
      );

  Map<String, dynamic> toJson() => {
        "pseudo_token": pseudoToken,
      };
}
