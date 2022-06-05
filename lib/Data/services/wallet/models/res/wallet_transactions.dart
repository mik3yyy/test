// To parse this JSON data, do
//
//     final transactions = transactionsFromJson(jsonString);

import 'dart:convert';

WalletTransactions walletTransactionsFromJson(String str) =>
    WalletTransactions.fromJson(json.decode(str));

String walletTransactionsToJson(WalletTransactions data) =>
    json.encode(data.toJson());

class WalletTransactions {
  WalletTransactions({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  String? status;
  Data? data;

  factory WalletTransactions.fromJson(Map<String, dynamic> json) =>
      WalletTransactions(
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
    required this.transactions,
  });

  List<Transaction> transactions;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        transactions: List<Transaction>.from(
            json["transactions"].map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
      };
}

class Transaction {
  Transaction({
    this.transactionRef,
    this.description,
    this.direction,
    this.currencyCode,
    this.amount,
    this.balanceBeforeTransaction,
    this.balanceAfterTransaction,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  String? transactionRef;
  String? description;
  Direction? direction;
  CurrencyCode? currencyCode;
  double? amount;
  double? balanceBeforeTransaction;
  double? balanceAfterTransaction;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        transactionRef: json["transaction_ref"],
        description: json["description"],
        direction: directionValues.map![json["direction"]],
        currencyCode: currencyCodeValues.map![json["currency_code"]],
        amount: json["amount"].toDouble(),
        balanceBeforeTransaction: json["balance_before_transaction"].toDouble(),
        balanceAfterTransaction: json["balance_after_transaction"].toDouble(),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "transaction_ref": transactionRef,
        "description": description,
        "direction": directionValues.reverse![direction],
        "currency_code": currencyCodeValues.reverse![currencyCode],
        "amount": amount,
        "balance_before_transaction": balanceBeforeTransaction,
        "balance_after_transaction": balanceAfterTransaction,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "user": user!.toJson(),
      };
}

enum CurrencyCode { usd, ngn, gbp, eur }

final currencyCodeValues = EnumValues({
  "EUR": CurrencyCode.eur,
  "GBP": CurrencyCode.gbp,
  "NGN": CurrencyCode.ngn,
  "USD": CurrencyCode.usd
});

enum Direction { credit, debit }

final directionValues =
    EnumValues({"credit": Direction.credit, "debit": Direction.debit});

class User {
  User({
    this.firstName,
    this.lastName,
    this.gender,
    this.dateOfBirth,
    this.accountNumber,
    this.refCode,
    this.email,
    this.phoneNumber,
    this.address,
    this.city,
    this.state,
    this.countryName,
    this.currencyCode,
    this.language,
    this.transactionPinAddedAt,
    this.verifiedAt,
    this.isBanned,
    this.profilePicture,
    this.timezone,
    this.createdAt,
    this.updatedAt,
  });

  String? firstName;
  String? lastName;
  dynamic gender;
  dynamic dateOfBirth;
  String? accountNumber;
  RefCode? refCode;
  Email? email;
  dynamic phoneNumber;
  dynamic address;
  dynamic city;
  dynamic state;
  CountryName? countryName;
  CurrencyCode? currencyCode;
  Language? language;
  DateTime? transactionPinAddedAt;
  DateTime? verifiedAt;
  int? isBanned;
  dynamic profilePicture;
  Timezone? timezone;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        dateOfBirth: json["date_of_birth"],
        accountNumber: json["account_number"],
        refCode: refCodeValues.map![json["ref_code"]],
        email: emailValues.map![json["email"]],
        phoneNumber: json["phone_number"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        countryName: countryNameValues.map![json["country_name"]],
        currencyCode: currencyCodeValues.map![json["currency_code"]],
        language: languageValues.map![json["language"]],
        transactionPinAddedAt: DateTime.parse(json["transaction_pin_added_at"]),
        verifiedAt: DateTime.parse(json["verified_at"]),
        isBanned: json["is_banned"],
        profilePicture: json["profile_picture"],
        timezone: timezoneValues.map![json["timezone"]],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "first_name": stNameValues.reverse![firstName],
        "last_name": stNameValues.reverse![lastName],
        "gender": gender,
        "date_of_birth": dateOfBirth,
        "account_number": accountNumber,
        "ref_code": refCodeValues.reverse![refCode],
        "email": emailValues.reverse![email],
        "phone_number": phoneNumber,
        "address": address,
        "city": city,
        "state": state,
        "country_name": countryNameValues.reverse![countryName],
        "currency_code": currencyCodeValues.reverse![currencyCode],
        "language": languageValues.reverse![language],
        "transaction_pin_added_at": transactionPinAddedAt!.toIso8601String(),
        "verified_at": verifiedAt!.toIso8601String(),
        "is_banned": isBanned,
        "profile_picture": profilePicture,
        "timezone": timezoneValues.reverse![timezone],
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

enum CountryName { NIGERIA }

final countryNameValues = EnumValues({"Nigeria": CountryName.NIGERIA});

enum Email { ETOEDIA_GMAIL_COM }

final emailValues = EnumValues({"etoedia@gmail.com": Email.ETOEDIA_GMAIL_COM});

enum StName { DAVID }

final stNameValues = EnumValues({"David": StName.DAVID});

enum Language { ENGLISH }

final languageValues = EnumValues({"English": Language.ENGLISH});

enum RefCode { DD_QS7_WY }

final refCodeValues = EnumValues({"DD-QS7WY": RefCode.DD_QS7_WY});

enum Timezone { AFRICA_LAGOS }

final timezoneValues = EnumValues({"Africa/Lagos": Timezone.AFRICA_LAGOS});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
