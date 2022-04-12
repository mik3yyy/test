// To parse this JSON data, do
//
//     final setCurrency = setCurrencyFromJson(jsonString);

import 'dart:convert';

SetCurrency setCurrencyFromJson(String str) =>
    SetCurrency.fromJson(json.decode(str));

String setCurrencyToJson(SetCurrency data) => json.encode(data.toJson());

class SetCurrency {
  SetCurrency({
    this.currency,
    this.language,
    this.country,
  });

  String? currency;
  String? language;
  String? country;

  factory SetCurrency.fromJson(Map<String, dynamic> json) => SetCurrency(
        currency: json["currency"],
        language: json["language"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "language": language,
        "country": country,
      };
}
