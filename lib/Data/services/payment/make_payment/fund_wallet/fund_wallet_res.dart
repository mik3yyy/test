// To parse this JSON data, do
//
//     final fundWalletRes = fundWalletResFromJson(jsonString);

import 'dart:convert';

FundWalletRes fundWalletResFromJson(String str) =>
    FundWalletRes.fromJson(json.decode(str));

String fundWalletResToJson(FundWalletRes data) => json.encode(data.toJson());

class FundWalletRes {
  FundWalletRes({
    this.paymentIntent,
    this.ephemeralKey,
    this.customer,
    this.publishableKey,
  });

  String? paymentIntent;
  String? ephemeralKey;
  String? customer;
  String? publishableKey;

  factory FundWalletRes.fromJson(Map<String, dynamic> json) => FundWalletRes(
        paymentIntent: json["paymentIntent"] ?? "",
        ephemeralKey: json["ephemeralKey"] ?? "",
        customer: json["customer"] ?? "",
        publishableKey: json["publishableKey"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "paymentIntent": paymentIntent ?? "",
        "ephemeralKey": ephemeralKey ?? "",
        "customer": customer ?? "",
        "publishableKey": publishableKey ?? "",
      };
}
