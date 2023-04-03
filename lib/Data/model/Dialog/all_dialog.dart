// To parse this JSON data, do
//
//     final allDialog = allDialogFromJson(jsonString);

import 'dart:convert';

AllDialog allDialogFromJson(String str) => AllDialog.fromJson(json.decode(str));

String allDialogToJson(AllDialog data) => json.encode(data.toJson());

class AllDialog {
  AllDialog({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  String? status;
  List<Datum>? data;

  factory AllDialog.fromJson(Map<String, dynamic> json) => AllDialog(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.dialog,
    this.title,
    this.img,
    this.privateDialogOtherUser,
    this.lastMessage,
  });

  Dialog? dialog;
  String? title;
  dynamic img;
  PrivateDialogOtherUser? privateDialogOtherUser;
  LastMessage? lastMessage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        dialog: json["dialog"] == null ? null : Dialog.fromJson(json["dialog"]),
        title: json["title"] ?? "",
        img: json["img"],
        privateDialogOtherUser: json["private_dialog_other_user"] == null
            ? null
            : PrivateDialogOtherUser.fromJson(
                json["private_dialog_other_user"]),
        lastMessage: json["last_message"] == null
            ? null
            : LastMessage.fromJson(json["last_message"]),
      );

  Map<String, dynamic> toJson() => {
        "dialog": dialog?.toJson(),
        "title": title,
        "img": img,
        "private_dialog_other_user": privateDialogOtherUser?.toJson(),
        "last_message": lastMessage?.toJson(),
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
  PrivateDialogOtherUser? initiator;

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
        initiator: json["initiator"] == null
            ? null
            : PrivateDialogOtherUser.fromJson(json["initiator"]),
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

class PrivateDialogOtherUser {
  PrivateDialogOtherUser({
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
  String? timezone;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deactivatedNumber;
  ProfilePicture? profilePicture;

  factory PrivateDialogOtherUser.fromJson(Map<String, dynamic> json) =>
      PrivateDialogOtherUser(
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
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

class LastMessage {
  LastMessage({
    this.id,
    this.dialogId,
    this.message,
    this.sentAt,
    this.ipAddress,
    this.userAgent,
    this.createdAt,
    this.updatedAt,
    this.sentByMe,
    this.attachments,
    this.from,
  });

  int? id;
  int? dialogId;
  String? message;
  DateTime? sentAt;
  String? ipAddress;
  String? userAgent;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? sentByMe;
  List<dynamic>? attachments;
  PrivateDialogOtherUser? from;

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
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
        sentByMe: json["sent_by_me"],
        attachments: json["attachments"] == null
            ? []
            : List<dynamic>.from(json["attachments"]!.map((x) => x)),
        from: json["from"] == null
            ? null
            : PrivateDialogOtherUser.fromJson(json["from"]),
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
        "sent_by_me": sentByMe,
        "attachments": attachments == null
            ? []
            : List<dynamic>.from(attachments!.map((x) => x)),
        "from": from?.toJson(),
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
