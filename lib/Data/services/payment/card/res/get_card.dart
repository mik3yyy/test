// To parse this JSON data, do
//
//     final getCardRes = getCardResFromJson(jsonString);

import 'dart:convert';

GetCardRes getCardResFromJson(String str) =>
    GetCardRes.fromJson(json.decode(str));

String getCardResToJson(GetCardRes data) => json.encode(data.toJson());

class GetCardRes {
  GetCardRes({
    this.message,
    this.status,
    required this.data,
  });

  String? message;
  String? status;
  Data data;

  factory GetCardRes.fromJson(Map<String, dynamic> json) => GetCardRes(
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
    required this.cards,
  });

  List<Cardd> cards;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cards: List<Cardd>.from(json["cards"].map((x) => Cardd.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cards": List<dynamic>.from(cards.map((x) => x.toJson())),
      };
}

class Cardd {
  Cardd({
    this.processor,
    this.createdAt,
    this.updatedAt,
    this.brand,
    this.expiry,
    this.country,
    this.cardId,
    this.isDefault,
    this.first6Digits,
    this.last4Digits,
  });

  String? processor;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? brand;
  String? expiry;
  String? country;
  String? cardId;
  int? isDefault;
  String? first6Digits;
  String? last4Digits;

  factory Cardd.fromJson(Map<String, dynamic> json) => Cardd(
        processor: json["processor"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        brand: json["brand"],
        expiry: json["expiry"],
        country: json["country"],
        cardId: json["card_id"],
        isDefault: json["is_default"],
        first6Digits: json["first6digits"],
        last4Digits: json["last4digits"],
      );

  Map<String, dynamic> toJson() => {
        "processor": processor,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "brand": brand,
        "expiry": expiry,
        "country": country,
        "card_id": cardId,
        "is_default": isDefault,
        "first6digits": first6Digits,
        "last4digits": last4Digits,
      };
}
