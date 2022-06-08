// To parse this JSON data, do
//
//     final userAccountDetails = userAccountDetailsFromJson(jsonString);

import 'dart:convert';

UserAccountDetails userAccountDetailsFromJson(String str) =>
    UserAccountDetails.fromJson(json.decode(str));

String userAccountDetailsToJson(UserAccountDetails data) =>
    json.encode(data.toJson());

class UserAccountDetails {
  UserAccountDetails({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  String? status;
  Data? data;

  factory UserAccountDetails.fromJson(Map<String, dynamic> json) =>
      UserAccountDetails(
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
    this.wallets,
  });

  List<Wallet>? wallets;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        wallets:
            List<Wallet>.from(json["wallets"].map((x) => Wallet.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "wallets": List<dynamic>.from(wallets!.map((x) => x.toJson())),
      };
}

class Wallet {
  Wallet({
    this.balance,
    this.currencyCode,
    this.createdAt,
    this.updatedAt,
    this.isDefault,
    this.currency,
  });

  num? balance;
  String? currencyCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? isDefault;
  Currency? currency;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        balance: json["balance"].toDouble() ?? 0.0,
        currencyCode: json["currency_code"] ?? '',
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isDefault: json["is_default"] ?? 0,
        currency: json["currency"] == null
            ? null
            : Currency.fromJson(json["currency"]),
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "currency_code": currencyCode,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "is_default": isDefault,
        "currency": currency!.toJson(),
      };
}

class Currency {
  Currency({
    this.id,
    this.name,
    this.code,
    this.symbol,
    this.nativeSymbol,
    this.namePlural,
    this.createdAt,
    this.updatedAt,
  });

  num? id;
  String? name;
  String? code;
  String? symbol;
  String? nativeSymbol;
  String? namePlural;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        code: json["code"] ?? '',
        symbol: json["symbol"] ?? '',
        nativeSymbol: json["native_symbol"] ?? '',
        namePlural: json["name_plural"] ?? '',
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "symbol": symbol,
        "native_symbol": nativeSymbol,
        "name_plural": namePlural,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
