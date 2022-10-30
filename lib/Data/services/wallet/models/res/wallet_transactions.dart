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
        "data": data?.toJson(),
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
  String? direction;
  String? currencyCode;
  num? amount;
  num? balanceBeforeTransaction;
  num? balanceAfterTransaction;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        transactionRef: json["transaction_ref"],
        description: json["description"],
        direction: json["direction"],
        currencyCode: json["currency_code"],
        amount: json["amount"] ?? 0.0,
        balanceBeforeTransaction: json["balance_before_transaction"] ?? 0.0,
        balanceAfterTransaction: json["balance_after_transaction"] ?? 0.0,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "transaction_ref": transactionRef,
        "description": description,
        "direction": direction,
        "currency_code": currencyCode,
        "amount": amount,
        "balance_before_transaction": balanceBeforeTransaction,
        "balance_after_transaction": balanceAfterTransaction,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
      };
}

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
  String? gender;
  dynamic dateOfBirth;
  String? accountNumber;
  String? refCode;
  String? email;
  dynamic phoneNumber;
  String? address;
  String? city;
  String? state;
  String? countryName;
  String? currencyCode;
  String? language;
  DateTime? transactionPinAddedAt;
  DateTime? verifiedAt;
  int? isBanned;
  dynamic profilePicture;
  String? timezone;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"] ?? "",
        dateOfBirth: json["date_of_birth"],
        accountNumber: json["account_number"],
        refCode: json["ref_code"] ?? "",
        email: json["email"] ?? "",
        phoneNumber: json["phone_number"],
        address: json["address"],
        city: json["city"] ?? "",
        state: json["state"] ?? "",
        countryName: json["country_name"] ?? "",
        currencyCode: json["currency_code"],
        language: json["language"] ?? "",
        transactionPinAddedAt: json["transaction_pin_added_at"] == null
            ? null
            : DateTime.parse(json["transaction_pin_added_at"]),
        verifiedAt: DateTime.parse(json["verified_at"]),
        isBanned: json["is_banned"],
        profilePicture: json["profile_picture"],
        timezone: json["timezone"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "date_of_birth": dateOfBirth,
        "account_number": accountNumber,
        "ref_code": refCode,
        "email": email,
        "phone_number": phoneNumber,
        "address": address,
        "city": city,
        "state": state,
        "country_name": countryName,
        "currency_code": currencyCode,
        "language": language,
        "transaction_pin_added_at": transactionPinAddedAt?.toIso8601String(),
        "verified_at": verifiedAt!.toIso8601String(),
        "is_banned": isBanned,
        "profile_picture": profilePicture,
        "timezone": timezone,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
