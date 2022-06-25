// // To parse this JSON data, do
// //
// //     final profileRes = profileResFromJson(jsonString);

// import 'dart:convert';

// ProfileRes profileResFromJson(String str) =>
//     ProfileRes.fromJson(json.decode(str));

// String profileResToJson(ProfileRes data) => json.encode(data.toJson());

// class ProfileRes {
//   ProfileRes({
//     this.message,
//     this.status,
//     required this.data,
//   });

//   String? message;
//   String? status;
//   Data data;

//   factory ProfileRes.fromJson(Map<String, dynamic> json) => ProfileRes(
//         message: json["message"],
//         status: json["status"],
//         data: Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "status": status,
//         "data": data.toJson(),
//       };
// }

// class Data {
//   Data({
//     required this.user,
//     required this.defaultWallet,
//   });

//   User user;
//   Wallet defaultWallet;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         user: User.fromJson(json["user"]),
//         defaultWallet: Wallet.fromJson(json["default_wallet"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "user": user.toJson(),
//         "default_wallet": defaultWallet.toJson(),
//       };
// }

// class Wallet {
//   Wallet({
//     this.balance,
//     this.currencyCode,
//     this.createdAt,
//     this.updatedAt,
//     this.isDefault,
//     this.entityType,
//     this.entityId,
//   });

//   num? balance;
//   String? currencyCode;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   num? isDefault;
//   dynamic entityType;
//   dynamic entityId;

//   factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
//         balance: json["balance"] ?? 0,
//         currencyCode: json["currency_code"] ?? "",
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         isDefault: json["is_default"] ?? 0,
//         entityType: json["entity_type"] ?? 0,
//         entityId: json["entity_id"] ?? 0,
//       );

//   Map<String, dynamic> toJson() => {
//         "balance": balance ?? 0,
//         "currency_code": currencyCode ?? "",
//         "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
//         "is_default": isDefault ?? 0,
//         "entity_type": entityType ?? "",
//         "entity_id": entityId ?? 0,
//       };
// }

// class User {
//   User({
//     required this.firstName,
//     required this.lastName,
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
//     this.wallets,
//   });

//   String firstName;
//   String lastName;
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
//   DateTime? transactionPinAddedAt;
//   DateTime? verifiedAt;
//   num? isBanned;
//   dynamic profilePicture;
//   String? timezone;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   List<Wallet>? wallets;

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         gender: json["gender"] ?? "",
//         dateOfBirth: json["date_of_birth"],
//         accountNumber: json["account_number"] ?? "",
//         refCode: json["ref_code"] ?? 0,
//         email: json["email"] ?? 0,
//         phoneNumber: json["phone_number"] ?? 0,
//         address: json["address"] ?? "",
//         city: json["city"] ?? "",
//         state: json["state"] ?? "",
//         countryName: json["country_name"],
//         currencyCode: json["currency_code"] ?? "",
//         language: json["language"],
//         transactionPinAddedAt: json["transaction_pin_added_at"] == null
//             ? null
//             : DateTime.parse(json["transaction_pin_added_at"]),
//         verifiedAt: json["verified_at"] == null
//             ? null
//             : DateTime.parse(json["verified_at"]),
//         isBanned: json["is_banned"] ?? 0,
//         profilePicture: json["profile_picture"],
//         timezone: json["timezone"] ?? "",
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         wallets: json["wallets"] == null
//             ? null
//             : List<Wallet>.from(json["wallets"].map((x) => Wallet.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "first_name": firstName,
//         "last_name": lastName,
//         "gender": gender,
//         "date_of_birth": dateOfBirth,
//         "account_number": accountNumber,
//         "ref_code": refCode ?? 0,
//         "email": email,
//         "phone_number": phoneNumber ?? "",
//         "address": address ?? "",
//         "city": city ?? "",
//         "state": state ?? "",
//         "country_name": countryName,
//         "currency_code": currencyCode ?? "",
//         "language": language,
//         "transaction_pin_added_at": transactionPinAddedAt == null
//             ? null
//             : transactionPinAddedAt!.toIso8601String(),
//         "verified_at":
//             verifiedAt == null ? null : verifiedAt!.toIso8601String(),
//         "is_banned": isBanned ?? 0,
//         "profile_picture": profilePicture,
//         "timezone": timezone ?? "",
//         "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
//         "wallets": wallets == null
//             ? null
//             : List<dynamic>.from(wallets!.map((x) => x.toJson())),
//       };
// }

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
    required this.data,
  });

  String? message;
  String? status;
  Data data;

  factory ProfileRes.fromJson(Map<String, dynamic> json) => ProfileRes(
        message: json["message"] ?? '',
        status: json["status"] ?? "",
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message ?? "",
        "status": status ?? "",
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.user,
    required this.defaultWallet,
  });

  User user;
  Wallet defaultWallet;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        defaultWallet: Wallet.fromJson(json["default_wallet"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "default_wallet": defaultWallet.toJson(),
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
        balance: json["balance"] ?? 0,
        currencyCode: json["currency_code"] ?? "",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isDefault: json["is_default"] ?? 0,
        entityType: json["entity_type"] ?? "",
        entityId: json["entity_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "balance": balance ?? 0,
        "currency_code": currencyCode ?? "",
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "is_default": isDefault ?? 0,
        "entity_type": entityType ?? "",
        "entity_id": entityId ?? "",
      };
}

class User {
  User({
    required this.firstName,
    required this.lastName,
    this.gender,
    this.dateOfBirth,
    required this.accountNumber,
    this.refCode,
    required this.email,
    this.phoneNumber,
    this.address,
    this.city,
    this.state,
    required this.countryName,
    this.currencyCode,
    required this.language,
    this.transactionPinAddedAt,
    this.verifiedAt,
    this.isBanned,
    this.profilePicture,
    this.timezone,
    this.createdAt,
    this.updatedAt,
    this.wallets,
  });

  String firstName;
  String lastName;
  String? gender;
  DateTime? dateOfBirth;
  String accountNumber;
  String? refCode;
  String email;
  String? phoneNumber;
  String? address;
  String? city;
  String? state;
  String countryName;
  String? currencyCode;
  String language;
  DateTime? transactionPinAddedAt;
  DateTime? verifiedAt;
  num? isBanned;
  ProfilePicture? profilePicture;
  String? timezone;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Wallet>? wallets;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"] ?? "",
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        accountNumber: json["account_number"],
        refCode: json["ref_code"] ?? "",
        email: json["email"],
        phoneNumber: json["phone_number"] ?? "",
        address: json["address"] ?? "",
        city: json["city"] ?? "",
        state: json["state"] ?? "",
        countryName: json["country_name"],
        currencyCode: json["currency_code"] ?? "",
        language: json["language"],
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
        wallets: json["wallets"] == null
            ? null
            : List<Wallet>.from(json["wallets"].map((x) => Wallet.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender ?? "",
        "date_of_birth": dateOfBirth?.toIso8601String(),
        "account_number": accountNumber,
        "ref_code": refCode ?? "",
        "email": email,
        "phone_number": phoneNumber ?? "",
        "address": address ?? "",
        "city": city ?? "",
        "state": state ?? "",
        "country_name": countryName,
        "currency_code": currencyCode ?? "",
        "language": language,
        "transaction_pin_added_at": transactionPinAddedAt == null
            ? null
            : transactionPinAddedAt!.toIso8601String(),
        "verified_at":
            verifiedAt == null ? null : verifiedAt!.toIso8601String(),
        "is_banned": isBanned ?? 0,
        "profile_picture": profilePicture?.toJson(),
        "timezone": timezone ?? "",
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "wallets": wallets == null
            ? null
            : List<dynamic>.from(wallets!.map((x) => x.toJson())),
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
        imageUrl: json["image_url"] ?? "",
        thumbnailUrl: json["thumbnail_url"] ?? "",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl ?? "",
        "thumbnail_url": thumbnailUrl ?? "",
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
