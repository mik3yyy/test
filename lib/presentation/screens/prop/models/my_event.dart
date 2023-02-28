// To parse this JSON data, do
//
//     final myEvent = myEventFromJson(jsonString);

import 'dart:convert';

MyEvent myEventFromJson(String str) => MyEvent.fromJson(json.decode(str));

String myEventToJson(MyEvent data) => json.encode(data.toJson());

class MyEvent {
  MyEvent({
    this.message,
  });

  SMS? message;

  factory MyEvent.fromJson(Map<String, dynamic> json) => MyEvent(
        message: json["message"] == null ? null : SMS.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class SMS {
  SMS({
    this.id,
    this.dialogId,
    this.message,
    this.sentAt,
    this.ipAddress,
    this.userAgent,
    this.createdAt,
    this.updatedAt,
    this.attachments,
    this.from,
    this.dialog,
  });

  int? id;
  int? dialogId;
  String? message;
  DateTime? sentAt;
  String? ipAddress;
  String? userAgent;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<dynamic>? attachments;
  From? from;
  Dialog? dialog;

  factory SMS.fromJson(Map<String, dynamic> json) => SMS(
        id: json["id"],
        dialogId: json["dialog_id"],
        message: json["message"],
        sentAt:
            json["sent_at"] == null ? null : DateTime.parse(json["sent_at"]),
        ipAddress: json["ip_address"],
        userAgent: json["user_agent"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        attachments: json["attachments"] == null
            ? []
            : List<dynamic>.from(json["attachments"]!.map((x) => x)),
        from: json["from"] == null ? null : From.fromJson(json["from"]),
        dialog: json["dialog"] == null ? null : Dialog.fromJson(json["dialog"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dialog_id": dialogId,
        "message": message,
        "sent_at": sentAt?.toIso8601String(),
        "ip_address": ipAddress,
        "user_agent": userAgent,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "attachments": attachments == null
            ? []
            : List<dynamic>.from(attachments!.map((x) => x)),
        "from": from?.toJson(),
        "dialog": dialog?.toJson(),
      };
}

class Dialog {
  Dialog({
    this.id,
    this.uuid,
    this.isRoom,
    this.name,
    this.description,
    this.dialogImg,
    this.createdAt,
    this.updatedAt,
    this.initiator,
  });

  int? id;
  String? uuid;
  int? isRoom;
  dynamic name;
  dynamic description;
  dynamic dialogImg;
  DateTime? createdAt;
  DateTime? updatedAt;
  From? initiator;

  factory Dialog.fromJson(Map<String, dynamic> json) => Dialog(
        id: json["id"],
        uuid: json["uuid"],
        isRoom: json["is_room"],
        name: json["name"],
        description: json["description"],
        dialogImg: json["dialog_img"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        initiator:
            json["initiator"] == null ? null : From.fromJson(json["initiator"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "is_room": isRoom,
        "name": name,
        "description": description,
        "dialog_img": dialogImg,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "initiator": initiator?.toJson(),
      };
}

class From {
  From({
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
    this.timezone,
    this.createdAt,
    this.updatedAt,
    this.deactivatedNumber,
    this.profilePicture,
  });

  String? firstName;
  String? lastName;
  dynamic gender;
  dynamic dateOfBirth;
  String? accountNumber;
  String? refCode;
  String? email;
  PhoneNumber? phoneNumber;
  dynamic address;
  dynamic city;
  dynamic state;
  String? countryName;
  String? currencyCode;
  String? language;
  DateTime? transactionPinAddedAt;
  DateTime? verifiedAt;
  int? isBanned;
  String? timezone;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deactivatedNumber;
  dynamic profilePicture;

  factory From.fromJson(Map<String, dynamic> json) => From(
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        dateOfBirth: json["date_of_birth"],
        accountNumber: json["account_number"],
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
        timezone: json["timezone"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deactivatedNumber: json["deactivated_number"],
        profilePicture: json["profile_picture"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "date_of_birth": dateOfBirth,
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
        "timezone": timezone,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deactivated_number": deactivatedNumber,
        "profile_picture": profilePicture,
      };
}

class PhoneNumber {
  PhoneNumber({
    this.phoneCode,
    this.phoneNumber,
  });

  dynamic phoneCode;
  dynamic phoneNumber;

  factory PhoneNumber.fromJson(Map<String, dynamic> json) => PhoneNumber(
        phoneCode: json["phone_code"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "phone_code": phoneCode,
        "phone_number": phoneNumber,
      };
}
