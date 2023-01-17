// To parse this JSON data, do
//
//     final failure = failureFromJson(jsonString);

import 'dart:convert';

GenericRes genericResFromJson(String str) =>
    GenericRes.fromJson(json.decode(str));

String genericResToJson(GenericRes data) => json.encode(data.toJson());

class GenericRes {
  GenericRes({
    this.message,
    this.status,
  });

  String? message;
  String? status;

  factory GenericRes.fromJson(Map<String, dynamic> json) => GenericRes(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
