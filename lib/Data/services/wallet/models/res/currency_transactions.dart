// To parse this JSON data, do
//
//     final currencyTransaction = currencyTransactionFromJson(jsonString);

import 'dart:convert';

CurrencyTransaction currencyTransactionFromJson(String str) =>
    CurrencyTransaction.fromJson(json.decode(str));

String currencyTransactionToJson(CurrencyTransaction data) =>
    json.encode(data.toJson());

class CurrencyTransaction {
  CurrencyTransaction({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data data;

  factory CurrencyTransaction.fromJson(Map<String, dynamic> json) =>
      CurrencyTransaction(
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
    required this.transactions,
  });

  List<Transactions> transactions;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        transactions: List<Transactions>.from(
            json["transactions"].map((x) => Transactions.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
      };
}

class Transactions {
  Transactions({
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

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        transactionRef: json["transaction_ref"] ?? "",
        description: json["description"] ?? "",
        direction: json["direction"] ?? "",
        currencyCode: json["currency_code"] ?? "",
        amount: json["amount"] ?? 0.0,
        balanceBeforeTransaction: json["balance_before_transaction"] ?? 0,
        balanceAfterTransaction: json["balance_after_transaction"] ?? 0,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "transaction_ref": transactionRef ?? "",
        "description": description,
        "direction": direction,
        "currency_code": currencyCode,
        "amount": amount ?? 0,
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
  num? isBanned;
  ProfilePicture? profilePicture;
  String? timezone;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? deactivatedNumber;

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
        deactivatedNumber: json["deactivated_number"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "date_of_birth": dateOfBirth?.toIso8601String(),
        "account_number": accountNumber ?? "",
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
        "profile_picture": profilePicture?.toJson(),
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
        phoneCode: json["phone_code"] ?? "unavailable",
        phoneNumber: json["phone_number"] ?? "unavailable",
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
        imageUrl: json["image_url"],
        thumbnailUrl: json["thumbnail_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "thumbnail_url": thumbnailUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}



// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
