// To parse this JSON data, do
//
//     final sepaReq = sepaReqFromJson(jsonString);

import 'dart:convert';

SepaReq sepaReqFromJson(String str) => SepaReq.fromJson(json.decode(str));

String sepaReqToJson(SepaReq data) => json.encode(data.toJson());

class SepaReq {
  SepaReq({
    required this.accountNumber,
    required this.routingNumber,
    required this.swiftCode,
    required this.bankName,
    required this.beneficiaryName,
    required this.beneficiaryAddress,
    required this.walletToDebit,
    required this.description,
    required this.amount,
    required this.currencyCode,
    required this.country,
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
  String walletToDebit;
  String description;
  String amount;
  String currencyCode;
  String country;
  String zip;
  String streetNo;
  String streetName;
  String city;

  factory SepaReq.fromJson(Map<String, dynamic> json) => SepaReq(
        accountNumber: json["account_number"],
        routingNumber: json["routing_number"],
        swiftCode: json["swift_code"],
        bankName: json["bank_name"],
        beneficiaryName: json["beneficiary_name"],
        beneficiaryAddress: json["beneficiary_address"],
        walletToDebit: json["wallet_to_debit"],
        description: json["description"],
        amount: json["amount"],
        currencyCode: json["currency_code"],
        country: json["country"],
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
        "wallet_to_debit": walletToDebit,
        "description": description,
        "amount": amount,
        "currency_code": currencyCode,
        "country": country,
        "zip": zip,
        "street_no": streetNo,
        "street_name": streetName,
        "city": city,
      };
}
