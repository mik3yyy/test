// To parse this JSON data, do
//
//     final bankDetailsRes = bankDetailsResFromJson(jsonString);

import 'dart:convert';

BankDetailsRes bankDetailsResFromJson(String str) =>
    BankDetailsRes.fromJson(json.decode(str));

String bankDetailsResToJson(BankDetailsRes data) => json.encode(data.toJson());

class BankDetailsRes {
  BankDetailsRes({
    this.message,
    this.status,
    required this.data,
  });

  String? message;
  String? status;
  Data data;

  factory BankDetailsRes.fromJson(Map<String, dynamic> json) => BankDetailsRes(
        message: json["message"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.accountName,
    this.accountNumber,
  });

  String? accountName;
  String? accountNumber;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accountName: json["account_name"],
        accountNumber: json["account_number"],
      );

  Map<String, dynamic> toJson() => {
        "account_name": accountName,
        "account_number": accountNumber,
      };
}
