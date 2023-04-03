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

  final Message? message;

  factory MyEvent.fromJson(Map<String, dynamic> json) => MyEvent(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  Message({
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

  final int? id;
  final int? dialogId;
  final String? message;
  final DateTime? sentAt;
  final String? ipAddress;
  final String? userAgent;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Attachment>? attachments;
  final From? from;
  final Dialog? dialog;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
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
            : List<Attachment>.from(
                json["attachments"]!.map((x) => Attachment.fromJson(x))),
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
            : List<dynamic>.from(attachments!.map((x) => x.toJson())),
        "from": from?.toJson(),
        "dialog": dialog?.toJson(),
      };
}

class Attachment {
  Attachment({
    this.url,
    this.pos,
    this.createdAt,
    this.updatedAt,
    this.fileName,
    this.fileType,
    this.thumbnailUrl,
  });

  final String? url;
  final int? pos;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? fileName;
  final String? fileType;
  final String? thumbnailUrl;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        url: json["url"],
        pos: json["pos"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        fileName: json["file_name"],
        fileType: json["file_type"],
        thumbnailUrl: json["thumbnail_url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "pos": pos,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "file_name": fileName,
        "file_type": fileType,
        "thumbnail_url": thumbnailUrl,
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

  final int? id;
  final String? uuid;
  final int? isRoom;
  final dynamic name;
  final dynamic description;
  final dynamic dialogImg;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final From? initiator;

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

  final String? firstName;
  final String? lastName;
  final dynamic gender;
  final dynamic dateOfBirth;
  final String? accountNumber;
  final String? refCode;
  final String? email;
  final PhoneNumber? phoneNumber;
  final dynamic address;
  final dynamic city;
  final dynamic state;
  final String? countryName;
  final String? currencyCode;
  final String? language;
  final DateTime? transactionPinAddedAt;
  final DateTime? verifiedAt;
  final int? isBanned;
  final String? timezone;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deactivatedNumber;
  final ProfilePicture? profilePicture;

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
        profilePicture: json["profile_picture"] == null
            ? null
            : ProfilePicture.fromJson(json["profile_picture"]),
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

  final dynamic phoneCode;
  final dynamic phoneNumber;

  factory PhoneNumber.fromJson(Map<String, dynamic> json) => PhoneNumber(
        phoneCode: json["phone_code"],
        phoneNumber: json["phone_number"],
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
