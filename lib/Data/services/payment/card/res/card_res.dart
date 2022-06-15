// To parse this JSON data, do
//
//     final addCardRes = addCardResFromJson(jsonString);

import 'dart:convert';

AddCardRes addCardResFromJson(String str) =>
    AddCardRes.fromJson(json.decode(str));

String addCardResToJson(AddCardRes data) => json.encode(data.toJson());

class AddCardRes {
  AddCardRes({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  String? status;
  Data? data;

  factory AddCardRes.fromJson(Map<String, dynamic> json) => AddCardRes(
        message: json["message"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.requiresAuth,
    this.mode,
    this.message,
    this.fields,
    this.depositRef,
    this.url,
  });

  bool? requiresAuth;
  String? mode;
  String? message;
  List<String>? fields;
  String? depositRef;
  String? url;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        requiresAuth: json["requires_auth"] ?? '',
        mode: json["mode"] ?? '',
        message: json["message"] ?? "",
        fields: json["fields"] == null
            ? null
            : List<String>.from(json["fields"].map((x) => x)),
        depositRef: json["deposit_ref"] ?? "",
        url: json["url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "requires_auth": requiresAuth ?? "",
        "mode": mode ?? "",
        "message": message ?? "",
        "fields":
            fields == null ? null : List<dynamic>.from(fields!.map((x) => x)),
        "deposit_ref": depositRef ?? "",
        "url": url ?? "",
      };
}
