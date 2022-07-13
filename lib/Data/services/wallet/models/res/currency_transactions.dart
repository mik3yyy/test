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
    this.message,
    this.status,
    required this.data,
  });

  String? message;
  String? status;
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
    required this.user,
  });

  String? transactionRef;
  String? description;
  Direction? direction;
  String? currencyCode;
  num? amount;
  num? balanceBeforeTransaction;
  num? balanceAfterTransaction;
  DateTime? createdAt;
  DateTime? updatedAt;
  User user;

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        transactionRef: json["transaction_ref"] ?? "",
        description: json["description"] ?? "",
        direction: json["direction"] == null
            ? null
            : directionValues.map[json["direction"]],
        currencyCode: json["currency_code"],
        amount: json["amount"] ?? 0,
        balanceBeforeTransaction: json["balance_before_transaction"] ?? 0,
        balanceAfterTransaction: json["balance_after_transaction"] ?? 0,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "transaction_ref": transactionRef ?? "",
        "description": description ?? "",
        "direction":
            direction == null ? null : directionValues.reverse[direction],
        "currency_code": currencyCode,
        "amount": amount ?? 0,
        "balance_before_transaction": balanceBeforeTransaction ?? 0,
        "balance_after_transaction": balanceAfterTransaction ?? 0,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "user": user.toJson(),
      };
}

enum TransactionCurrencyCode { usd }

final transactionCurrencyCodeValues =
    EnumValues({"USD": TransactionCurrencyCode.usd});

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
    // this.address,
    // this.city,
    // this.state,
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
  DateTime? dateOfBirth;
  String? accountNumber;
  RefCode? refCode;
  String? email;
  String? phoneNumber;
  // Address? address;
  // City? city;
  // State? state;
  String? countryName;
  String? currencyCode;
  String? language;
  DateTime? transactionPinAddedAt;
  DateTime? verifiedAt;
  int? isBanned;
  ProfilePicture? profilePicture;
  Timezone? timezone;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        accountNumber: json["account_number"] ?? "",
        refCode: json["ref_code"] == null
            ? null
            : refCodeValues.map[json["ref_code"]],
        email: json["email"] ?? "",
        phoneNumber: json["phone_number"] ?? "",
        // address:
        //     json["address"] == null ? null : addressValues.map[json["address"]],
        // city: json["city"] == null ? null : cityValues.map[json["city"]],
        // state: json["state"] == null ? null : stateValues.map[json["state"]],
        countryName: json["country_name"] ?? "",
        currencyCode: json["currency_code"] ?? "",
        language: json["language"] ?? "",
        transactionPinAddedAt: DateTime.parse(json["transaction_pin_added_at"]),
        verifiedAt: DateTime.parse(json["verified_at"]),
        isBanned: json["is_banned"],
        profilePicture: json["profile_picture"] == null
            ? null
            : ProfilePicture.fromJson(json["profile_picture"]),
        timezone: json["timezone"] == null
            ? null
            : timezoneValues.map[json["timezone"]],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender ?? "",
        "date_of_birth": dateOfBirth?.toIso8601String(),
        "account_number": accountNumber ?? "",
        "ref_code": refCode == null ? null : refCodeValues.reverse[refCode],
        "email": email ?? "",
        "phone_number": phoneNumber ?? "",
        // "address": address == null ? null : addressValues.reverse[address],
        // "city": city == null ? null : cityValues.reverse[city],
        // "state": state == null ? null : stateValues.reverse[state],
        "country_name": countryName ?? "",
        "currency_code": currencyCode ?? "",
        "language": language ?? "",
        "transaction_pin_added_at": transactionPinAddedAt!.toIso8601String(),
        "verified_at": verifiedAt?.toIso8601String(),
        "is_banned": isBanned ?? 0,
        "profile_picture": profilePicture?.toJson(),
        "timezone": timezone == null ? null : timezoneValues.reverse[timezone],
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl ?? "",
        "thumbnail_url": thumbnailUrl ?? "",
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

enum RefCode { eaop4nb }

final refCodeValues = EnumValues({"EA-OP4NB": RefCode.eaop4nb});

enum State { rivers }

final stateValues = EnumValues({"Rivers": State.rivers});

enum Timezone { africaLagos }

final timezoneValues = EnumValues({"Africa/Lagos": Timezone.africaLagos});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap;
    return reverseMap;
  }
}
