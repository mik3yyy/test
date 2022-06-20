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
    this.user,
    this.defaultWallet,
    this.tokens,
  });

  User? user;
  Wallet? defaultWallet;
  Tokens? tokens;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        defaultWallet: Wallet.fromJson(json["default_wallet"]),
        tokens: Tokens.fromJson(json["tokens"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
        "default_wallet": defaultWallet!.toJson(),
        "tokens": tokens!.toJson(),
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

  num? balance;
  String? currencyCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? isDefault;
  dynamic entityType;
  dynamic entityId;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        balance: json["balance"].toDouble(),
        currencyCode: json["currency_code"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isDefault: json["is_default"],
        entityType: json["entity_type"],
        entityId: json["entity_id"],
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "currency_code": currencyCode,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "is_default": isDefault,
        "entity_type": entityType,
        "entity_id": entityId,
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
        authToken: json["auth_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "auth_token": authToken,
        "refresh_token": refreshToken,
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
    this.wallets,
  });

  String? firstName;
  String? lastName;
  dynamic gender;
  dynamic dateOfBirth;
  String? accountNumber;
  String? refCode;
  String? email;
  dynamic phoneNumber;
  dynamic address;
  dynamic city;
  dynamic state;
  String? countryName;
  String? currencyCode;
  String? language;
  DateTime? transactionPinAddedAt;
  DateTime? verifiedAt;
  num? isBanned;
  dynamic profilePicture;
  String? timezone;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Wallet>? wallets;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        dateOfBirth: json["date_of_birth"],
        accountNumber: json["account_number"],
        refCode: json["ref_code"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        countryName: json["country_name"],
        currencyCode: json["currency_code"],
        language: json["language"],
        transactionPinAddedAt: DateTime.parse(json["transaction_pin_added_at"]),
        verifiedAt: DateTime.parse(json["verified_at"]),
        isBanned: json["is_banned"],
        profilePicture: json["profile_picture"],
        timezone: json["timezone"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        wallets:
            List<Wallet>.from(json["wallets"].map((x) => Wallet.fromJson(x))),
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
        "transaction_pin_added_at": transactionPinAddedAt!.toIso8601String(),
        "verified_at": verifiedAt!.toIso8601String(),
        "is_banned": isBanned,
        "profile_picture": profilePicture,
        "timezone": timezone,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "wallets": List<dynamic>.from(wallets!.map((x) => x.toJson())),
      };
}
























// // To parse this JSON data, do
// //
// //     final signinRes = signinResFromJson(jsonString);

// import 'dart:convert';

// SigninRes signinResFromJson(String str) => SigninRes.fromJson(json.decode(str));

// String signinResToJson(SigninRes data) => json.encode(data.toJson());

// class SigninRes {
//   SigninRes({
//     this.message,
//     this.status,
//     this.data,
//   });

//   String? message;
//   String? status;
//   Data? data;

//   factory SigninRes.fromJson(Map<String, dynamic> json) => SigninRes(
//         message: json["message"],
//         status: json["status"],
//         data: Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "status": status,
//         "data": data!.toJson(),
//       };
// }

// class Data {
//   Data({
//     this.user,
//     this.tokens,
//   });

//   User? user;
//   Tokens? tokens;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         user: User.fromJson(json["user"]),
//         tokens: Tokens.fromJson(json["tokens"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "user": user!.toJson(),
//         "tokens": tokens!.toJson(),
//       };
// }

// class Tokens {
//   Tokens({
//     this.authToken,
//     this.refreshToken,
//   });

//   String? authToken;
//   String? refreshToken;

//   factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
//         authToken: json["auth_token"],
//         refreshToken: json["refresh_token"],
//       );

//   Map<String, dynamic> toJson() => {
//         "auth_token": authToken,
//         "refresh_token": refreshToken,
//       };
// }

// class User {
//   User({
//     this.firstName,
//     this.lastName,
//     this.gender,
//     this.dateOfBirth,
//     this.accountNumber,
//     this.refCode,
//     this.email,
//     this.phoneNumber,
//     this.address,
//     this.city,
//     this.state,
//     this.countryName,
//     this.currencyCode,
//     this.language,
//     this.transactionPinAddedAt,
//     this.verifiedAt,
//     this.isBanned,
//     this.profilePicture,
//     this.timezone,
//     this.createdAt,
//     this.updatedAt,
//   });

//   String? firstName;
//   String? lastName;
//   dynamic gender;
//   dynamic dateOfBirth;
//   String? accountNumber;
//   String? refCode;
//   String? email;
//   dynamic phoneNumber;
//   dynamic address;
//   dynamic city;
//   dynamic state;
//   String? countryName;
//   String? currencyCode;
//   String? language;
//   dynamic transactionPinAddedAt;
//   DateTime? verifiedAt;
//   int? isBanned;
//   dynamic profilePicture;
//   dynamic timezone;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         gender: json["gender"],
//         dateOfBirth: json["date_of_birth"],
//         accountNumber: json["account_number"],
//         refCode: json["ref_code"],
//         email: json["email"],
//         phoneNumber: json["phone_number"],
//         address: json["address"],
//         city: json["city"],
//         state: json["state"],
//         countryName: json["country_name"],
//         currencyCode: json["currency_code"],
//         language: json["language"],
//         transactionPinAddedAt: json["transaction_pin_added_at"],
//         verifiedAt: DateTime.parse(json["verified_at"]),
//         isBanned: json["is_banned"],
//         profilePicture: json["profile_picture"],
//         timezone: json["timezone"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "first_name": firstName,
//         "last_name": lastName,
//         "gender": gender,
//         "date_of_birth": dateOfBirth,
//         "account_number": accountNumber,
//         "ref_code": refCode,
//         "email": email,
//         "phone_number": phoneNumber,
//         "address": address,
//         "city": city,
//         "state": state,
//         "country_name": countryName,
//         "currency_code": currencyCode,
//         "language": language,
//         "transaction_pin_added_at": transactionPinAddedAt,
//         "verified_at": verifiedAt!.toIso8601String(),
//         "is_banned": isBanned,
//         "profile_picture": profilePicture,
//         "timezone": timezone,
//         "created_at": createdAt!.toIso8601String(),
//         "updated_at": updatedAt!.toIso8601String(),
//       };
// }
