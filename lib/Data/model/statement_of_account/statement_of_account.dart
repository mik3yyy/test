// To parse this JSON data, do
//
//     final statementOfAccount = statementOfAccountFromJson(jsonString);

import 'dart:convert';

StatementOfAccount statementOfAccountFromJson(String str) =>
    StatementOfAccount.fromJson(json.decode(str));

String statementOfAccountToJson(StatementOfAccount data) =>
    json.encode(data.toJson());

class StatementOfAccount {
  StatementOfAccount({
    this.message,
    this.status,
    required this.data,
  });

  String? message;
  String? status;
  Data data;

  factory StatementOfAccount.fromJson(Map<String, dynamic> json) =>
      StatementOfAccount(
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
    required this.statements,
  });

  List<Statement> statements;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        statements: List<Statement>.from(
            json["statements"].map((x) => Statement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statements": List<dynamic>.from(statements.map((x) => x.toJson())),
      };
}

class Statement {
  Statement({
    this.id,
    this.userId,
    this.description,
    this.currencyCode,
    this.amount,
    this.direction,
    this.entityType,
    this.entityId,
    this.createdAt,
    this.updatedAt,
    this.entity,
  });

  num? id;
  num? userId;
  String? description;
  String? currencyCode;
  num? amount;
  String? direction;
  String? entityType;
  String? entityId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Entity? entity;

  factory Statement.fromJson(Map<String, dynamic> json) => Statement(
        id: json["id"],
        userId: json["user_id"],
        description: json["description"],
        currencyCode: json["currency_code"],
        amount: json["amount"],
        direction: json["direction"],
        entityType: json["entity_type"] ?? "",
        entityId: json["entity_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        entity: Entity.fromJson(json["entity"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "description": description,
        "currency_code": currencyCode,
        "amount": amount,
        "direction": direction,
        "entity_type": entityType ?? "",
        "entity_id": entityId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "entity": entity?.toJson(),
      };
}

// enum Direction { CREDIT, DEBIT }

// final directionValues = EnumValues({
//     "credit": Direction.CREDIT,
//     "debit": Direction.DEBIT
// });

class Entity {
  Entity({
    this.isCardPayment,
    this.paymentRef,
    this.paymentMethod,
    this.amount,
    this.depositCurrencyCode,
    this.walletCurrencyCode,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.amountInGbp,
    this.processor,
    this.saveCard,
    this.wallet,
    this.transactionRef,
    this.description,
    this.direction,
    this.currencyCode,
    this.balanceBeforeTransaction,
    this.balanceAfterTransaction,
    this.user,
  });

  num? isCardPayment;
  String? paymentRef;
  String? paymentMethod;
  num? amount;
  String? depositCurrencyCode;
  String? walletCurrencyCode;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? amountInGbp;
  String? processor;
  num? saveCard;
  Wallet? wallet;
  String? transactionRef;
  String? description;
  String? direction;
  String? currencyCode;
  num? balanceBeforeTransaction;
  num? balanceAfterTransaction;
  User? user;

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        isCardPayment: json["is_card_payment"] ?? 0,
        paymentRef: json["payment_ref"] ?? "",
        paymentMethod: json["payment_method"] ?? "",
        amount: json["amount"] ?? 0,
        depositCurrencyCode: json["deposit_currency_code"] ?? "",
        walletCurrencyCode: json["wallet_currency_code"] ?? "",
        status: json["status"] ?? "",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        amountInGbp: json["amount_in_gbp"] ?? 0,
        processor: json["processor"] ?? "",
        saveCard: json["save_card"] ?? 0,
        wallet: json["wallet"] == null ? null : Wallet.fromJson(json["wallet"]),
        transactionRef: json["transaction_ref"] ?? "",
        description: json["description"] ?? "",
        direction: json["direction"] ?? "",
        currencyCode: json["currency_code"] ?? "",
        balanceBeforeTransaction: json["balance_before_transaction"] ?? 0,
        balanceAfterTransaction: json["balance_after_transaction"] ?? 0,
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "is_card_payment": isCardPayment,
        "payment_ref": paymentRef,
        "payment_method": paymentMethod,
        "amount": amount,
        "deposit_currency_code": depositCurrencyCode,
        "wallet_currency_code": walletCurrencyCode,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "amount_in_gbp": amountInGbp ?? "",
        "processor": processor ?? "",
        "save_card": saveCard,
        "wallet": wallet?.toJson(),
        "transaction_ref": transactionRef,
        "description": description,
        "direction": direction,
        "currency_code": currencyCode,
        "balance_before_transaction": balanceBeforeTransaction,
        "balance_after_transaction": balanceAfterTransaction,
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
  dynamic profilePicture;
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
        refCode: json["ref_code"],
        email: json["email"],
        phoneNumber: json["phone_number"] == null
            ? null
            : PhoneNumber.fromJson(json["phone_number"]),
        address: json["address"],
        city: json["city"],
        state: json["state"],
        countryName: json["country_name"],
        currencyCode: json["currency_code"],
        language: json["language"],
        transactionPinAddedAt: json["transaction_pin_added_at"] == null
            ? null
            : DateTime.parse(json["transaction_pin_added_at"]),
        verifiedAt: json["verified_at"] == null
            ? null
            : DateTime.parse(json["verified_at"]),
        isBanned: json["is_banned"],
        profilePicture: json["profile_picture"],
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
        phoneCode: json["phone_code"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "phone_code": phoneCode,
        "phone_number": phoneNumber,
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
        balance: json["balance"] ?? "",
        currencyCode: json["currency_code"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isDefault: json["is_default"],
        entityType: json["entity_type"],
        entityId: json["entity_id"],
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "currency_code": currencyCode,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_default": isDefault,
        "entity_type": entityType,
        "entity_id": entityId,
      };
}
