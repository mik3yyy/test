// To parse this JSON data, do
//
//     final creatAccountRes = creatAccountResFromJson(jsonString);

import 'dart:convert';

CreatAccountRes creatAccountResFromJson(String str) =>
    CreatAccountRes.fromJson(json.decode(str));

String creatAccountResToJson(CreatAccountRes data) =>
    json.encode(data.toJson());

class CreatAccountRes {
  CreatAccountRes({
    this.message,
    this.status,
    this.data,
  });

  final String? message;
  final String? status;
  final Data? data;

  CreatAccountRes copyWith({
    String? message,
    String? status,
    Data? data,
  }) =>
      CreatAccountRes(
        message: message ?? this.message,
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory CreatAccountRes.fromJson(Map<String, dynamic> json) =>
      CreatAccountRes(
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
    this.verificationMode,
  });

  final String? verificationMode;

  Data copyWith({
    String? verificationMode,
  }) =>
      Data(
        verificationMode: verificationMode ?? this.verificationMode,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        verificationMode: json["verification_mode"],
      );

  Map<String, dynamic> toJson() => {
        "verification_mode": verificationMode,
      };
}
