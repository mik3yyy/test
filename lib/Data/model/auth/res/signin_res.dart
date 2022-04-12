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
    this.tokens,
  });

  User? user;
  Tokens? tokens;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        tokens: Tokens.fromJson(json["tokens"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
        "tokens": tokens!.toJson(),
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
    this.verifiedAt,
    this.isBanned,
    this.profilePicture,
    this.userTimezone,
    this.createdAt,
    this.updatedAt,
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
  DateTime? verifiedAt;
  int? isBanned;
  dynamic profilePicture;
  dynamic userTimezone;
  DateTime? createdAt;
  DateTime? updatedAt;

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
        verifiedAt: DateTime.parse(json["verified_at"]),
        isBanned: json["is_banned"],
        profilePicture: json["profile_picture"],
        userTimezone: json["user_timezone"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "verified_at": verifiedAt!.toIso8601String(),
        "is_banned": isBanned,
        "profile_picture": profilePicture,
        "user_timezone": userTimezone,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
