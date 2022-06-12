// To parse this JSON data, do
//
//     final ibanReq = ibanReqFromJson(jsonString);

import 'dart:convert';

IbanReq ibanReqFromJson(String str) => IbanReq.fromJson(json.decode(str));

String ibanReqToJson(IbanReq data) => json.encode(data.toJson());

class IbanReq {
  IbanReq({
    required this.accountNumber,
    required this.routingNumber,
    required this.swiftCode,
    required this.bankName,
    required this.beneficiaryName,
    required this.beneficiaryAddress,
    required this.description,
    required this.amount,
    required this.zip,
    required this.streetNo,
    required this.streetName,
    required this.city,
  });

  String accountNumber;
  String routingNumber;
  String swiftCode;
  String bankName;
  String beneficiaryName;
  String beneficiaryAddress;
  String description;
  String amount;
  String zip;
  String streetNo;
  String streetName;
  String city;

  factory IbanReq.fromJson(Map<String, dynamic> json) => IbanReq(
        accountNumber: json["account_number"],
        routingNumber: json["routing_number"],
        swiftCode: json["swift_code"],
        bankName: json["bank_name"],
        beneficiaryName: json["beneficiary_name"],
        beneficiaryAddress: json["beneficiary_address"],
        description: json["description"],
        amount: json["amount"],
        zip: json["zip"],
        streetNo: json["street_no"],
        streetName: json["street_name"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "account_number": accountNumber,
        "routing_number": routingNumber,
        "swift_code": swiftCode,
        "bank_name": bankName,
        "beneficiary_name": beneficiaryName,
        "beneficiary_address": beneficiaryAddress,
        "description": description,
        "amount": amount,
        "zip": zip,
        "street_no": streetNo,
        "street_name": streetName,
        "city": city,
      };
}
