// To parse this JSON data, do
//
//     final addCard = addCardFromJson(jsonString);

import 'dart:convert';

AddCard addCardFromJson(String str) => AddCard.fromJson(json.decode(str));

String addCardToJson(AddCard data) => json.encode(data.toJson());

class AddCard {
  AddCard({
    required this.nameOnCard,
    required this.cardNumber,
    required this.expiration,
    required this.cvv,
    required this.amount,
    required this.depositCurrencyCode,
    required this.walletCurrencyCode,
    this.saveCard,
  });

  String nameOnCard;
  String cardNumber;
  String expiration;
  String cvv;
  String amount;
  String depositCurrencyCode;
  String walletCurrencyCode;
  bool? saveCard;

  factory AddCard.fromJson(Map<String, dynamic> json) => AddCard(
        nameOnCard: json["name_on_card"],
        cardNumber: json["card_number"],
        expiration: json["expiration"],
        cvv: json["cvv"],
        amount: json["amount"],
        depositCurrencyCode: json["deposit_currency_code"],
        walletCurrencyCode: json["wallet_currency_code"],
        saveCard: json["save_card"],
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
      };
}
