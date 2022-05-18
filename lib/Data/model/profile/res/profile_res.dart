// To parse this JSON data, do
//
//     final profileRes = profileResFromJson(jsonString);

import 'dart:convert';

ProfileRes profileResFromJson(String str) =>
    ProfileRes.fromJson(json.decode(str));

String profileResToJson(ProfileRes data) => json.encode(data.toJson());

class ProfileRes {
  ProfileRes({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  String? status;
  Data? data;

  factory ProfileRes.fromJson(Map<String, dynamic> json) => ProfileRes(
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
  });

  User? user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
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
  dynamic timezone;
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
        transactionPinAddedAt: DateTime.parse(json["transaction_pin_added_at"]),
        verifiedAt: DateTime.parse(json["verified_at"]),
        isBanned: json["is_banned"],
        profilePicture: json["profile_picture"],
        timezone: json["timezone"],
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
        "transaction_pin_added_at": transactionPinAddedAt!.toIso8601String(),
        "verified_at": verifiedAt!.toIso8601String(),
        "is_banned": isBanned,
        "profile_picture": profilePicture,
        "timezone": timezone,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
