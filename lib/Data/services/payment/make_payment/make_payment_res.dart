// To parse this JSON data, do
//
//     final makePaymentReq = makePaymentReqFromJson(jsonString);

import 'dart:convert';

MakePaymentReq makePaymentReqFromJson(String str) =>
    MakePaymentReq.fromJson(json.decode(str));

String makePaymentReqToJson(MakePaymentReq data) => json.encode(data.toJson());

class MakePaymentReq {
  MakePaymentReq({
    this.bankCode,
    this.accountNumber,
    this.accountName,
    this.amount,
    this.description,
  });

  String? bankCode;
  String? accountNumber;
  String? accountName;
  int? amount;
  String? description;

  factory MakePaymentReq.fromJson(Map<String, dynamic> json) => MakePaymentReq(
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
