import 'dart:convert';

ContactRes contactResFromJson(String str) =>
    ContactRes.fromJson(json.decode(str));

String contactResToJson(ContactRes data) => json.encode(data.toJson());

class ContactRes {
  ContactRes({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  String? status;
  Data? data;

  factory ContactRes.fromJson(Map<String, dynamic> json) => ContactRes(
        message: json["message"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.updatedAt,
    this.createdAt,
    this.id,
    required this.contact,
  });

  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  Contact contact;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        contact: Contact.fromJson(json["contact"]),
      );

  Map<String, dynamic> toJson() => {
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "contact": contact.toJson(),
      };
}

class Contact {
  Contact({
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

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
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
