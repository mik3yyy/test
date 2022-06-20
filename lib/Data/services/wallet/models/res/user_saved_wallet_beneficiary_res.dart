// To parse this JSON data, do
//
//     final userSavedWalletBeneficiaryRes = userSavedWalletBeneficiaryResFromJson(jsonString);

import 'dart:convert';

UserSavedWalletBeneficiaryRes userSavedWalletBeneficiaryResFromJson(
        String str) =>
    UserSavedWalletBeneficiaryRes.fromJson(json.decode(str));

String userSavedWalletBeneficiaryResToJson(
        UserSavedWalletBeneficiaryRes data) =>
    json.encode(data.toJson());

class UserSavedWalletBeneficiaryRes {
  UserSavedWalletBeneficiaryRes({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  String? status;
  Data? data;

  factory UserSavedWalletBeneficiaryRes.fromJson(Map<String, dynamic> json) =>
      UserSavedWalletBeneficiaryRes(
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
    this.walletBeneficiaries,
  });

  List<WalletBeneficiary>? walletBeneficiaries;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        walletBeneficiaries: List<WalletBeneficiary>.from(
            json["wallet_beneficiaries"]
                .map((x) => WalletBeneficiary.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "wallet_beneficiaries":
            List<dynamic>.from(walletBeneficiaries!.map((x) => x.toJson())),
      };
}

class WalletBeneficiary {
  WalletBeneficiary({
    this.id,
    this.walletBeneficiaryId,
    this.createdAt,
    this.updatedAt,
    this.beneficiary,
  });

  num? id;
  String? walletBeneficiaryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Beneficiary? beneficiary;

  factory WalletBeneficiary.fromJson(Map<String, dynamic> json) =>
      WalletBeneficiary(
        id: json["id"],
        walletBeneficiaryId: json["wallet_beneficiary_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        beneficiary: Beneficiary.fromJson(json["beneficiary"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "wallet_beneficiary_id": walletBeneficiaryId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "beneficiary": beneficiary!.toJson(),
      };
}

class Beneficiary {
  Beneficiary({
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
  String? timezone;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Beneficiary.fromJson(Map<String, dynamic> json) => Beneficiary(
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
