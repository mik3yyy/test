// To parse this JSON data, do
//
//     final signinRes = signinResFromJson(jsonString);

import 'dart:convert';

SigninRes signinResFromJson(String str) => SigninRes.fromJson(json.decode(str));

String signinResToJson(SigninRes data) => json.encode(data.toJson());

class SigninRes {
  SigninRes({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  String? status;
  Data? data;

  factory SigninRes.fromJson(Map<String, dynamic> json) => SigninRes(
        message: json["message"] ?? "",
        status: json["status"] ?? "",
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message ?? "",
        "status": status ?? "",
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    required this.user,
    this.defaultWallet,
    this.tokens,
  });

  User user;
  Wallet? defaultWallet;
  Tokens? tokens;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        defaultWallet: json["default_wallet"] == null
            ? null
            : Wallet.fromJson(json["default_wallet"]),
        tokens: json["tokens"] == null ? null : Tokens.fromJson(json["tokens"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "default_wallet":
            defaultWallet == null ? null : defaultWallet!.toJson(),
        "tokens": tokens == null ? null : tokens!.toJson(),
      };
}

class Wallet {
  Wallet({
    this.balance,
    this.currencyCode,
    this.createdAt,
    this.updatedAt,
    this.isDefault,
    this.entityType,
    this.entityId,
  });

  String? balance;
  String? currencyCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? isDefault;
  dynamic entityType;
  dynamic entityId;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        balance: json["balance"] ?? '',
        currencyCode: json["currency_code"] ?? "",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isDefault: json["is_default"] ?? 0,
        entityType: json["entity_type"],
        entityId: json["entity_id"],
      );

  Map<String, dynamic> toJson() => {
        "balance": balance ?? '',
        "currency_code": currencyCode ?? "",
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "is_default": isDefault ?? 0,
        "entity_type": entityType ?? "",
        "entity_id": entityId ?? "",
      };
}

class Tokens {
  Tokens({
    this.authToken,
    this.refreshToken,
  });

  String? authToken;
  String? refreshToken;

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        authToken: json["auth_token"] ?? "",
        refreshToken: json["refresh_token"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "auth_token": authToken ?? "",
        "refresh_token": refreshToken ?? "",
      };
}

class User {
  User({
    required this.firstName,
    required this.lastName,
    this.gender,
    this.dateOfBirth,
    required this.accountNumber,
    required this.refCode,
    required this.email,
    this.phoneNumber,
    this.address,
    this.city,
    this.state,
    required this.countryName,
    this.currencyCode,
    required this.language,
    this.transactionPinAddedAt,
    required this.verifiedAt,
    this.isBanned,
    this.profilePicture,
    this.timezone,
    required this.createdAt,
    required this.updatedAt,
    this.wallets,
  });

  String firstName;
  String lastName;
  dynamic gender;
  dynamic dateOfBirth;
  String accountNumber;
  String refCode;
  String email;
  dynamic phoneNumber;
  dynamic address;
  dynamic city;
  dynamic state;
  String countryName;
  String? currencyCode;
  String language;
  dynamic transactionPinAddedAt;
  DateTime verifiedAt;
  num? isBanned;
  dynamic profilePicture;
  String? timezone;
  DateTime createdAt;
  DateTime updatedAt;
  List<Wallet>? wallets;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"] ?? "",
        dateOfBirth: json["date_of_birth"],
        accountNumber: json["account_number"],
        refCode: json["ref_code"],
        email: json["email"],
        phoneNumber: json["phone_number"] ?? 0,
        address: json["address"] ?? "",
        city: json["city"] ?? "",
        state: json["state"] ?? "",
        countryName: json["country_name"],
        currencyCode: json["currency_code"] ?? "",
        language: json["language"],
        transactionPinAddedAt: json["transaction_pin_added_at"],
        verifiedAt: DateTime.parse(json["verified_at"]),
        isBanned: json["is_banned"] ?? 0,
        profilePicture: json["profile_picture"],
        timezone: json["timezone"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        wallets: json["wallets"] == null
            ? null
            : List<Wallet>.from(json["wallets"].map((x) => Wallet.fromJson(x))),
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
        "currency_code": currencyCode ?? "",
        "language": language,
        "transaction_pin_added_at": transactionPinAddedAt,
        "verified_at": verifiedAt.toIso8601String(),
        "is_banned": isBanned ?? 0,
        "profile_picture": profilePicture,
        "timezone": timezone ?? "",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "wallets": wallets == null
            ? null
            : List<dynamic>.from(wallets!.map((x) => x.toJson())),
      };
}
