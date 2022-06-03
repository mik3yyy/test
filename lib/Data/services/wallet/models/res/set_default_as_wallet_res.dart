// To parse this JSON data, do
//
//     final setWalletAsDefaultRes = setWalletAsDefaultResFromJson(jsonString);

import 'dart:convert';

SetWalletAsDefaultRes setWalletAsDefaultResFromJson(String str) =>
    SetWalletAsDefaultRes.fromJson(json.decode(str));

String setWalletAsDefaultResToJson(SetWalletAsDefaultRes data) =>
    json.encode(data.toJson());

class SetWalletAsDefaultRes {
  SetWalletAsDefaultRes({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  String? status;
  Data? data;

  factory SetWalletAsDefaultRes.fromJson(Map<String, dynamic> json) =>
      SetWalletAsDefaultRes(
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
    this.wallet,
  });

  Wallet? wallet;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        wallet: Wallet.fromJson(json["wallet"]),
      );

  Map<String, dynamic> toJson() => {
        "wallet": wallet!.toJson(),
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

  num? balance;
  String? currencyCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? isDefault;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        balance: json["balance"] ?? 0,
        currencyCode: json["currency_code"] ?? '',
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isDefault: json["is_default"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "currency_code": currencyCode,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "is_default": isDefault,
      };
}
