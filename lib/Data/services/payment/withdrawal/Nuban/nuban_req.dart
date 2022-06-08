// To parse this JSON data, do
//
//     final nubanReq = nubanReqFromJson(jsonString);

import 'dart:convert';

NubanReq nubanReqFromJson(String str) => NubanReq.fromJson(json.decode(str));

String nubanReqToJson(NubanReq data) => json.encode(data.toJson());

class NubanReq {
  NubanReq({
    required this.bankCode,
    required this.accountNumber,
    required this.accountName,
    required this.amount,
    this.description,
  });

  String bankCode;
  String accountNumber;
  String accountName;
  int amount;
  String? description;

  factory NubanReq.fromJson(Map<String, dynamic> json) => NubanReq(
        bankCode: json["bank_code"],
        accountNumber: json["account_number"],
        accountName: json["account_name"],
        amount: json["amount"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "bank_code": bankCode,
        "account_number": accountNumber,
        "account_name": accountName,
        "amount": amount,
        "description": description,
      };
}
