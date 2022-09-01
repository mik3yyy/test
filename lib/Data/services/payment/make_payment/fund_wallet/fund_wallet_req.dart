// To parse this JSON data, do
//
//     final fundWalletReq = fundWalletReqFromJson(jsonString);

import 'dart:convert';

FundWalletReq fundWalletReqFromJson(String str) =>
    FundWalletReq.fromJson(json.decode(str));

String fundWalletReqToJson(FundWalletReq data) => json.encode(data.toJson());

class FundWalletReq {
  FundWalletReq({
    required this.amount,
    // required this.depositCurrencyCode,
    required this.walletCurrencyCode,
  });

  int amount;
  // String depositCurrencyCode;
  String walletCurrencyCode;

  factory FundWalletReq.fromJson(Map<String, dynamic> json) => FundWalletReq(
        amount: json["amount"],
        walletCurrencyCode: json["wallet_currency_code"],
        // walletCurrencyCode: json["wallet_currency_code"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        // "deposit_currency_code": depositCurrencyCode,
        "wallet_currency_code": walletCurrencyCode,
      };
}
