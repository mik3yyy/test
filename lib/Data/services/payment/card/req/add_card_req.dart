// To parse this JSON data, do
//
//     final addCardReq = addCardReqFromJson(jsonString);

import 'dart:convert';

AddCardReq addCardReqFromJson(String str) =>
    AddCardReq.fromJson(json.decode(str));

String addCardReqToJson(AddCardReq data) => json.encode(data.toJson());

class AddCardReq {
  AddCardReq({
    this.nameOnCard,
    this.cardNumber,
    this.expiration,
    this.cvv,
    this.amount,
    this.depositCurrencyCode,
    this.walletCurrencyCode,
    this.saveCard,
    this.depositRef,
    this.authorization,
  });

  String? nameOnCard;
  String? cardNumber;
  String? expiration;
  String? cvv;
  String? amount;
  String? depositCurrencyCode;
  String? walletCurrencyCode;
  bool? saveCard;
  String? depositRef;
  Authorization? authorization;

  factory AddCardReq.fromJson(Map<String, dynamic> json) => AddCardReq(
        nameOnCard: json["name_on_card"],
        cardNumber: json["card_number"],
        expiration: json["expiration"],
        cvv: json["cvv"],
        amount: json["amount"],
        depositCurrencyCode: json["deposit_currency_code"],
        walletCurrencyCode: json["wallet_currency_code"],
        saveCard: json["save_card"],
        depositRef: json["deposit_ref"] ?? "",
        authorization: json["authorization"] == null
            ? null
            : Authorization.fromJson(json["authorization"]),
      );

  Map<String, dynamic> toJson() => {
        "name_on_card": nameOnCard,
        "card_number": cardNumber,
        "expiration": expiration,
        "cvv": cvv,
        "amount": amount,
        "deposit_currency_code": depositCurrencyCode,
        "wallet_currency_code": walletCurrencyCode,
        "save_card": saveCard,
        "deposit_ref": depositRef ?? "",
        "authorization": authorization == null ? null : authorization!.toJson(),
      };
}

class Authorization {
  Authorization({
    this.mode,
    this.city,
    this.address,
    this.state,
    this.country,
    this.zipcode,
  });

  String? mode;
  String? city;
  String? address;
  String? state;
  String? country;
  String? zipcode;

  factory Authorization.fromJson(Map<String, dynamic> json) => Authorization(
        mode: json["mode"] ?? "",
        city: json["city"] ?? "",
        address: json["address"] ?? "",
        state: json["state"] ?? "",
        country: json["country"] ?? "",
        zipcode: json["zipcode"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "mode": mode ?? "",
        "city": city ?? "",
        "address": address ?? "",
        "state": state ?? "",
        "country": country ?? "",
        "zipcode": zipcode ?? "",
      };
}
