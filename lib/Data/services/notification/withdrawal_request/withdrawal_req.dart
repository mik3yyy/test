// To parse this JSON data, do
//
//     final getWithdrawalReq = getWithdrawalReqFromJson(jsonString);

import 'dart:convert';

GetWithdrawalReq getWithdrawalReqFromJson(String str) =>
    GetWithdrawalReq.fromJson(json.decode(str));

String getWithdrawalReqToJson(GetWithdrawalReq data) =>
    json.encode(data.toJson());

class GetWithdrawalReq {
  GetWithdrawalReq({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  String? status;
  Data? data;

  factory GetWithdrawalReq.fromJson(Map<String, dynamic> json) =>
      GetWithdrawalReq(
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
    this.withdrawals,
  });

  List<Withdrawal>? withdrawals;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        withdrawals: List<Withdrawal>.from(
            json["withdrawals"].map((x) => Withdrawal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "withdrawals": List<dynamic>.from(withdrawals!.map((x) => x.toJson())),
      };
}

class Withdrawal {
  Withdrawal({
    this.bankTransferRef,
    this.bankTransferId,
    this.accountType,
    this.provider,
    this.bankaccountType,
    this.currencyCode,
    this.amount,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.bankaccount,
    this.wallet,
  });

  String? bankTransferRef;
  String? bankTransferId;
  String? accountType;
  String? provider;
  String? bankaccountType;
  String? currencyCode;
  int? amount;
  String? description;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Bankaccount? bankaccount;
  Wallet? wallet;

  factory Withdrawal.fromJson(Map<String, dynamic> json) => Withdrawal(
        bankTransferRef: json["bank_transfer_ref"],
        bankTransferId: json["bank_transfer_id"],
        accountType: json["account_type"],
        provider: json["provider"],
        bankaccountType: json["bankaccount_type"],
        currencyCode: json["currency_code"],
        amount: json["amount"],
        description: json["description"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        bankaccount: Bankaccount.fromJson(json["bankaccount"]),
        wallet: Wallet.fromJson(json["wallet"]),
      );

  Map<String, dynamic> toJson() => {
        "bank_transfer_ref": bankTransferRef,
        "bank_transfer_id": bankTransferId,
        "account_type": accountType,
        "provider": provider,
        "bankaccount_type": bankaccountType,
        "currency_code": currencyCode,
        "amount": amount,
        "description": description,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "bankaccount": bankaccount!.toJson(),
        "wallet": wallet!.toJson(),
      };
}

class Bankaccount {
  Bankaccount({
    this.id,
    this.accountType,
    this.bankCode,
    this.accountNumber,
    this.accountName,
    this.createdAt,
    this.updatedAt,
    this.routingNumber,
    this.swiftCode,
    this.bankName,
    this.beneficiaryName,
    this.beneficiaryAddress,
    this.beneficiaryCountry,
    this.postalCode,
    this.streetNumber,
    this.streetName,
    this.city,
  });

  int? id;
  String? accountType;
  String? bankCode;
  String? accountNumber;
  String? accountName;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? routingNumber;
  String? swiftCode;
  String? bankName;
  String? beneficiaryName;
  String? beneficiaryAddress;
  String? beneficiaryCountry;
  String? postalCode;
  String? streetNumber;
  String? streetName;
  String? city;

  factory Bankaccount.fromJson(Map<String, dynamic> json) => Bankaccount(
        id: json["id"],
        accountType: json["account_type"],
        bankCode: json["bank_code"] ?? "",
        accountNumber: json["account_number"],
        accountName: json["account_name"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        routingNumber: json["routing_number"] ?? "",
        swiftCode: json["swift_code"] ?? "",
        bankName: json["bank_name"] ?? "",
        beneficiaryName: json["beneficiary_name"] ?? "",
        beneficiaryAddress: json["beneficiary_address"] ?? "",
        beneficiaryCountry: json["beneficiary_country"] ?? "",
        postalCode: json["postal_code"] ?? "",
        streetNumber: json["street_number"] ?? "",
        streetName: json["street_name"] ?? "",
        city: json["city"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "account_type": accountType,
        "bank_code": bankCode ?? "",
        "account_number": accountNumber,
        "account_name": accountName ?? "",
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "routing_number": routingNumber ?? "",
        "swift_code": swiftCode ?? "",
        "bank_name": bankName ?? "",
        "beneficiary_name": beneficiaryName ?? "",
        "beneficiary_address": beneficiaryAddress ?? "",
        "beneficiary_country": beneficiaryCountry ?? "",
        "postal_code": postalCode ?? "",
        "street_number": streetNumber ?? "",
        "street_name": streetName ?? "",
        "city": city ?? "",
      };
}

class Wallet {
  Wallet({
    this.balance,
    this.currencyCode,
    this.createdAt,
    this.updatedAt,
    this.isDefault,
  });

  double? balance;
  String? currencyCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? isDefault;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        balance: json["balance"].toDouble(),
        currencyCode: json["currency_code"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isDefault: json["is_default"],
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "currency_code": currencyCode,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "is_default": isDefault,
      };
}
