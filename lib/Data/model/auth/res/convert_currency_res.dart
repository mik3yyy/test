// To parse this JSON data, do
//
//     final convertCurrencyRes = convertCurrencyResFromJson(jsonString);

import 'dart:convert';

ConvertCurrencyRes convertCurrencyResFromJson(String str) =>
    ConvertCurrencyRes.fromJson(json.decode(str));

String convertCurrencyResToJson(ConvertCurrencyRes data) =>
    json.encode(data.toJson());

class ConvertCurrencyRes {
  ConvertCurrencyRes({
    this.message,
    this.status,
    required this.data,
  });

  final String? message;
  final String? status;
  final Data data;

  factory ConvertCurrencyRes.fromJson(Map<String, dynamic> json) =>
      ConvertCurrencyRes(
        message: json["message"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.rates,
  });

  final Rates rates;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        rates: Rates.fromJson(json["rates"]),
      );

  Map<String, dynamic> toJson() => {
        "rates": rates.toJson(),
      };
}

class Rates {
  Rates({
    this.base,
    this.target,
    this.rate,
    this.baseAmount,
    this.convertedTargetAmount,
  });

  final String? base;
  final String? target;
  final String? rate;
  final String? baseAmount;
  final String? convertedTargetAmount;

  factory Rates.fromJson(Map<String, dynamic> json) => Rates(
        base: json["base"],
        target: json["target"],
        rate: json["rate"],
        baseAmount: json["base_amount"],
        convertedTargetAmount: json["converted_target_amount"],
      );

  Map<String, dynamic> toJson() => {
        "base": base,
        "target": target,
        "rate": rate,
        "base_amount": baseAmount,
        "converted_target_amount": convertedTargetAmount,
      };
}
