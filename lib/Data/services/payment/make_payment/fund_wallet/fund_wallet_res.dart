// To parse this JSON data, do
//
//     final fundWalletRes = fundWalletResFromJson(jsonString);

import 'dart:convert';

FundWalletRes fundWalletResFromJson(String str) =>
    FundWalletRes.fromJson(json.decode(str));

String fundWalletResToJson(FundWalletRes data) => json.encode(data.toJson());

class FundWalletRes {
  FundWalletRes({
    this.status,
    this.message,
    this.data,
    this.link,
  });

  String? status;
  String? message;
  FundWalletResData? data;
  Link? link;

  factory FundWalletRes.fromJson(Map<String, dynamic> json) => FundWalletRes(
        status: json["status"],
        message: json["message"],
        data: FundWalletResData.fromJson(json["data"]),
        link: Link.fromJson(json["link"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
        "link": link!.toJson(),
      };
}

class FundWalletResData {
  FundWalletResData({
    this.paymentRef,
    this.paymentMethod,
    this.depositCurrencyCode,
    this.walletCurrencyCode,
    this.amount,
    this.updatedAt,
    this.createdAt,
  });

  String? paymentRef;
  String? paymentMethod;
  String? depositCurrencyCode;
  String? walletCurrencyCode;
  int? amount;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory FundWalletResData.fromJson(Map<String, dynamic> json) =>
      FundWalletResData(
        paymentRef: json["payment_ref"],
        paymentMethod: json["payment_method"],
        depositCurrencyCode: json["deposit_currency_code"],
        walletCurrencyCode: json["wallet_currency_code"],
        amount: json["amount"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "payment_ref": paymentRef,
        "payment_method": paymentMethod,
        "deposit_currency_code": depositCurrencyCode,
        "wallet_currency_code": walletCurrencyCode,
        "amount": amount,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
      };
}

class Link {
  Link({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  LinkData? data;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        status: json["status"],
        message: json["message"],
        data: LinkData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class LinkData {
  LinkData({
    this.link,
  });

  String? link;

  factory LinkData.fromJson(Map<String, dynamic> json) => LinkData(
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
      };
}
