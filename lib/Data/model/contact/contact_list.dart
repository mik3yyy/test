// To parse this JSON data, do
//
//     final contactList = contactListFromJson(jsonString);

import 'dart:convert';

ContactList contactListFromJson(String str) =>
    ContactList.fromJson(json.decode(str));

String contactListToJson(ContactList data) => json.encode(data.toJson());

class ContactList {
  ContactList({
    this.message,
    this.status,
    required this.data,
  });

  String? message;
  String? status;
  Data data;

  factory ContactList.fromJson(Map<String, dynamic> json) => ContactList(
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
    required this.contacts,
  });

  List<ContactElement> contacts;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        contacts: json["contacts"] == null
            ? []
            : List<ContactElement>.from(
                json["contacts"].map((x) => ContactElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "contacts": List<dynamic>.from(contacts.map((x) => x.toJson())),
      };
}

class ContactElement {
  ContactElement({
    this.id,
    this.isBlocked,
    this.createdAt,
    this.updatedAt,
    this.contact,
  });

  int? id;
  int? isBlocked;
  DateTime? createdAt;
  DateTime? updatedAt;
  ContactContact? contact;

  factory ContactElement.fromJson(Map<String, dynamic> json) => ContactElement(
        id: json["id"],
        isBlocked: json["is_blocked"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        contact: ContactContact.fromJson(json["contact"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_blocked": isBlocked,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "contact": contact?.toJson(),
      };
}

class ContactContact {
  ContactContact({
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

  factory ContactContact.fromJson(Map<String, dynamic> json) => ContactContact(
        firstName: json["first_name"] ?? "unavailable",
        lastName: json["last_name"] ?? "unavailable",
        gender: json["gender"] ?? "unavailable",
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        accountNumber: json["account_number"] ?? "",
        refCode: json["ref_code"] ?? "unavailable",
        email: json["email"] ?? "unavailable",
        phoneNumber: json["phone_number"] == null
            ? null
            : PhoneNumber.fromJson(json["phone_number"]),
        address: json["address"] ?? "unavailable",
        city: json["city"] ?? "unavailable",
        state: json["state"] ?? "unavailable",
        countryName: json["country_name"] ?? "unavailable",
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
        "transaction_pin_added_at": transactionPinAddedAt?.toIso8601String(),
        "verified_at": verifiedAt?.toIso8601String(),
        "is_banned": isBanned,
        "profile_picture": profilePicture,
        "timezone": timezone,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
        "created_at": createdAt,
        "updated_at": updatedAt,
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
