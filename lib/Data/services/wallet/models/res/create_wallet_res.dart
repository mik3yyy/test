// // To parse this JSON data, do
// //
// //     final createWalletRes = createWalletResFromJson(jsonString);

// import 'dart:convert';

// CreateWalletRes createWalletResFromJson(String str) =>
//     CreateWalletRes.fromJson(json.decode(str));

// String createWalletResToJson(CreateWalletRes data) =>
//     json.encode(data.toJson());

// class CreateWalletRes {
//   CreateWalletRes({
//     this.message,
//     this.status,
//     this.data,
//   });

//   String? message;
//   String? status;
//   Data? data;

//   factory CreateWalletRes.fromJson(Map<String, dynamic> json) =>
//       CreateWalletRes(
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
//     this.wallet,
//   });

//   Wallet? wallet;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         wallet: Wallet.fromJson(json["wallet"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "wallet": wallet!.toJson(),
//       };
// }

// class Wallet {
//   Wallet({
//     this.balance,
//     this.currencyCode,
//     this.createdAt,
//     this.updatedAt,
//     this.isDefault,
//     this.user,
//   });

//   num? balance;
//   String? currencyCode;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   num? isDefault;
//   User? user;

//   factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
//         balance: json["balance"] ?? '',
//         currencyCode: json["currency_code"] ?? '',
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         isDefault: json["is_default"] ?? 0,
//         user: json["user"] == null ? null : User.fromJson(json["user"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "balance": balance,
//         "currency_code": currencyCode,
//         "created_at": createdAt!.toIso8601String(),
//         "updated_at": updatedAt!.toIso8601String(),
//         "is_default": isDefault,
//         "user": user!.toJson(),
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
//   String? gender;
//   DateTime? dateOfBirth;
//   String? accountNumber;
//   String? refCode;
//   String? email;
//   String? phoneNumber;
//   String? address;
//   String? city;
//   String? state;
//   String? countryName;
//   String? currencyCode;
//   String? language;
//   DateTime? transactionPinAddedAt;
//   DateTime? verifiedAt;
//   num? isBanned;
//   ProfilePicture? profilePicture;
//   String? timezone;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         firstName: json["first_name"] ?? '',
//         lastName: json["last_name"],
//         gender: json["gender"],
//         dateOfBirth: json["dateOfBirth"] == null
//             ? null
//             : DateTime.parse(json["date_of_birth"]),
//         accountNumber: json["account_number"] ?? '',
//         refCode: json["ref_code"] ?? '',
//         email: json["email"] ?? '',
//         phoneNumber: json["phone_number"] ?? '',
//         address: json["address"] ?? '',
//         city: json["city"] ?? '',
//         state: json["state"] ?? '',
//         countryName: json["country_name"] ?? '',
//         currencyCode: json["currency_code"] ?? '',
//         language: json["language"] ?? "",
//         transactionPinAddedAt: json["transactionPinAddedAt"] == null
//             ? null
//             : DateTime.parse(json["transaction_pin_added_at"]),
//         verifiedAt: json["verifiedAt"] == null
//             ? null
//             : DateTime.parse(json["verified_at"]),
//         isBanned: json["is_banned"] ?? 0,
//         profilePicture: json["profilePicture"] == null
//             ? null
//             : ProfilePicture.fromJson(json["profile_picture"]),
//         timezone: json["timezone"] ?? '',
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "first_name": firstName,
//         "last_name": lastName,
//         "gender": gender,
//         "date_of_birth": dateOfBirth!.toIso8601String(),
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
//         "transaction_pin_added_at": transactionPinAddedAt!.toIso8601String(),
//         "verified_at": verifiedAt!.toIso8601String(),
//         "is_banned": isBanned,
//         "profile_picture": profilePicture!.toJson(),
//         "timezone": timezone,
//         "created_at": createdAt!.toIso8601String(),
//         "updated_at": updatedAt!.toIso8601String(),
//       };
// }

// To parse this JSON data, do
//
//     final createWalletRes = createWalletResFromJson(jsonString);

import 'dart:convert';

CreateWalletRes createWalletResFromJson(String str) =>
    CreateWalletRes.fromJson(json.decode(str));

String createWalletResToJson(CreateWalletRes data) =>
    json.encode(data.toJson());

class CreateWalletRes {
  CreateWalletRes({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data data;

  factory CreateWalletRes.fromJson(Map<String, dynamic> json) =>
      CreateWalletRes(
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
    required this.wallet,
  });

  Wallet wallet;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        wallet: Wallet.fromJson(json["wallet"]),
      );

  Map<String, dynamic> toJson() => {
        "wallet": wallet.toJson(),
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
    this.user,
  });

  String? balance;
  String? currencyCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? isDefault;
  dynamic entityType;
  dynamic entityId;
  User? user;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        balance: json["balance"] ?? "0.0",
        currencyCode: json["currency_code"] ?? "",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isDefault: json["is_default"],
        entityType: json["entity_type"],
        entityId: json["entity_id"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "currency_code": currencyCode,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_default": isDefault,
        "entity_type": entityType,
        "entity_id": entityId,
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
    this.deactivatedNumber,
  });

  String? firstName;
  String? lastName;
  String? gender;
  DateTime? dateOfBirth;
  String? accountNumber;
  String? refCode;
  String? email;
  PhoneNumber? phoneNumber;
  String? address;
  String? city;
  String? state;
  String? countryName;
  String? currencyCode;
  String? language;
  DateTime? transactionPinAddedAt;
  DateTime? verifiedAt;
  int? isBanned;
  ProfilePicture? profilePicture;
  String? timezone;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deactivatedNumber;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        gender: json["gender"] ?? "",
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        accountNumber: json["account_number"] ?? "",
        refCode: json["ref_code"] ?? "",
        email: json["email"] ?? "",
        phoneNumber: json["phone_number"] == null
            ? null
            : PhoneNumber.fromJson(json["phone_number"]),
        address: json["address"] ?? "",
        city: json["city"] ?? "",
        state: json["state"] ?? "",
        countryName: json["country_name"] ?? "",
        currencyCode: json["currency_code"] ?? "",
        language: json["language"] ?? "",
        transactionPinAddedAt: json["transaction_pin_added_at"] == null
            ? null
            : DateTime.parse(json["transaction_pin_added_at"]),
        verifiedAt: json["verified_at"] == null
            ? null
            : DateTime.parse(json["verified_at"]),
        isBanned: json["is_banned"] ?? 0,
        profilePicture: json["profile_picture"] == null
            ? null
            : ProfilePicture.fromJson(json["profile_picture"]),
        timezone: json["timezone"] ?? "",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deactivatedNumber: json["deactivated_number"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "date_of_birth": dateOfBirth?.toIso8601String(),
        "account_number": accountNumber,
        "ref_code": refCode,
        "email": email,
        "phone_number": phoneNumber?.toJson(),
        "address": address,
        "city": city,
        "state": state,
        "country_name": countryName,
        "currency_code": currencyCode,
        "language": language,
        "transaction_pin_added_at": transactionPinAddedAt?.toIso8601String(),
        "verified_at": verifiedAt?.toIso8601String(),
        "is_banned": isBanned,
        "profile_picture": profilePicture,
        "timezone": timezone,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deactivated_number": deactivatedNumber,
      };
}

class PhoneNumber {
  PhoneNumber({
    this.phoneCode,
    this.phoneNumber,
  });

  String? phoneCode;
  String? phoneNumber;

  factory PhoneNumber.fromJson(Map<String, dynamic> json) => PhoneNumber(
        phoneCode: json["phone_code"] ?? "",
        phoneNumber: json["phone_number"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "phone_code": phoneCode,
        "phone_number": phoneNumber,
      };
}

class ProfilePicture {
  ProfilePicture({
    this.imageUrl,
    this.thumbnailUrl,
    this.createdAt,
    this.updatedAt,
  });

  String? imageUrl;
  String? thumbnailUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ProfilePicture.fromJson(Map<String, dynamic> json) => ProfilePicture(
        imageUrl: json["image_url"] ?? '',
        thumbnailUrl: json["thumbnail_url"] ?? '',
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "thumbnail_url": thumbnailUrl,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
