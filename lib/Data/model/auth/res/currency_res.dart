// To parse this JSON data, do
//
//     final currencyRes = currencyResFromJson(jsonString);

import 'dart:convert';

CurrencyRes currencyResFromJson(String str) =>
    CurrencyRes.fromJson(json.decode(str));

String currencyResToJson(CurrencyRes data) => json.encode(data.toJson());

class CurrencyRes {
  CurrencyRes({
    this.message,
    this.status,
    required this.data,
  });

  String? message;
  String? status;
  Data data;

  factory CurrencyRes.fromJson(Map<String, dynamic> json) => CurrencyRes(
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
    required this.currencies,
  });

  List<Currency> currencies;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currencies: List<Currency>.from(
            json["currencies"].map((x) => Currency.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "currencies": List<dynamic>.from(currencies.map((x) => x.toJson())),
      };
}

class Currency {
  Currency({
    this.name,
    this.code,
  });

  String? name;
  String? code;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
      };
}
