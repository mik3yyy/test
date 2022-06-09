// To parse this JSON data, do
//
//     final beneficiaryAccount = beneficiaryAccountFromJson(jsonString);

import 'dart:convert';

BeneficiaryAccount beneficiaryAccountFromJson(String str) =>
    BeneficiaryAccount.fromJson(json.decode(str));

String beneficiaryAccountToJson(BeneficiaryAccount data) =>
    json.encode(data.toJson());

class BeneficiaryAccount {
  BeneficiaryAccount({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  String? status;
  Data? data;

  factory BeneficiaryAccount.fromJson(Map<String, dynamic> json) =>
      BeneficiaryAccount(
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
    this.beneficiaries,
  });

  List<Beneficiary>? beneficiaries;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        beneficiaries: List<Beneficiary>.from(
            json["beneficiaries"].map((x) => Beneficiary.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "beneficiaries":
            List<dynamic>.from(beneficiaries!.map((x) => x.toJson())),
      };
}

class Beneficiary {
  Beneficiary({
    this.id,
    this.accountType,
    this.accountName,
    this.accountNumber,
    this.routingNumber,
    this.swiftCode,
    this.bankCode,
    this.bankName,
    this.beneficiaryName,
    this.beneficiaryCountry,
    this.postalCode,
    this.streetNumber,
    this.streetName,
    this.city,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? accountType;
  String? accountName;
  String? accountNumber;
  String? routingNumber;
  String? swiftCode;
  String? bankName;
  String? bankCode;
  String? beneficiaryName;
  String? beneficiaryCountry;
  String? postalCode;
  String? streetNumber;
  String? streetName;
  String? city;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Beneficiary.fromJson(Map<String, dynamic> json) => Beneficiary(
        id: json["id"],
        accountType: json["account_type"],
        accountName: json["account_name"] ?? "",
        accountNumber: json["account_number"],
        routingNumber: json["routing_number"] ?? "",
        swiftCode: json["swift_code"] ?? "",
        bankCode: json["bank_code"] ?? "",
        bankName: json["bank_name"] ?? "",
        beneficiaryName: json["beneficiary_name"],
        beneficiaryCountry: json["beneficiary_country"],
        postalCode: json["postal_code"] ?? "",
        streetNumber: json["street_number"] ?? "",
        streetName: json["street_name"] ?? "",
        city: json["city"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "account_type": accountType,
        "account_number": accountNumber,
        "routing_number": routingNumber ?? "",
        "account_name": accountName ?? "",
        "swift_code": swiftCode ?? "",
        "bank_code": bankCode ?? "",
        "bank_name": bankName,
        "beneficiary_name": beneficiaryName,
        "beneficiary_country": beneficiaryCountry,
        "postal_code": postalCode,
        "street_number": streetNumber ?? "",
        "street_name": streetName ?? "",
        "city": city ?? "",
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
