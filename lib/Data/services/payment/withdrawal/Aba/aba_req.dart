// To parse this JSON data, do
//
//     final abaReq = abaReqFromJson(jsonString);

import 'dart:convert';

AbaReq abaReqFromJson(String str) => AbaReq.fromJson(json.decode(str));

String abaReqToJson(AbaReq data) => json.encode(data.toJson());

class AbaReq {
  AbaReq({
    required this.accountNumber,
    required this.routingNumber,
    required this.swiftCode,
    required this.bankName,
    required this.beneficiaryName,
    required this.beneficiaryAddress,
    required this.walletToDebit,
    required this.description,
    required this.amount,
  });

  String accountNumber;
  String routingNumber;
  String swiftCode;
  String bankName;
  String beneficiaryName;
  String beneficiaryAddress;
  String walletToDebit;
  String description;
  String amount;

  factory AbaReq.fromJson(Map<String, dynamic> json) => AbaReq(
        accountNumber: json["account_number"],
        routingNumber: json["routing_number"],
        swiftCode: json["swift_code"],
        bankName: json["bank_name"],
        beneficiaryName: json["beneficiary_name"],
        beneficiaryAddress: json["beneficiary_address"],
        walletToDebit: json["wallet_to_debit"],
        description: json["description"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "account_number": accountNumber,
        "routing_number": routingNumber,
        "swift_code": swiftCode,
        "bank_name": bankName,
        "beneficiary_name": beneficiaryName,
        "beneficiary_address": beneficiaryAddress,
        "wallet_to_debit": walletToDebit,
        "description": description,
        "amount": amount,
      };
}
