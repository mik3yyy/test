// To parse this JSON data, do
//
//     final savedId = savedIdFromJson(jsonString);

import 'dart:convert';

SavedId savedIdFromJson(String str) => SavedId.fromJson(json.decode(str));

String savedIdToJson(SavedId data) => json.encode(data.toJson());

class SavedId {
  SavedId({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  String? status;
  Data? data;

  factory SavedId.fromJson(Map<String, dynamic> json) => SavedId(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    required this.identifications,
  });

  List<Identification> identifications;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        identifications: json["identifications"] == null
            ? []
            : List<Identification>.from(
                json["identifications"].map((x) => Identification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "identifications":
            List<dynamic>.from(identifications.map((x) => x.toJson())),
      };
}

class Identification {
  Identification({
    this.id,
    this.userId,
    this.fileFront,
    this.fileBack,
    this.idType,
    this.idNo,
    this.dateVerified,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? fileFront;
  dynamic fileBack;
  String? idType;
  String? idNo;
  dynamic dateVerified;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Identification.fromJson(Map<String, dynamic> json) => Identification(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        fileFront: json["file_front"] ?? "",
        fileBack: json["file_back"],
        idType: json["id_type"] ?? "",
        idNo: json["id_no"] ?? "",
        dateVerified: json["date_verified"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "file_front": fileFront,
        "file_back": fileBack,
        "id_type": idType,
        "id_no": idNo,
        "date_verified": dateVerified,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
