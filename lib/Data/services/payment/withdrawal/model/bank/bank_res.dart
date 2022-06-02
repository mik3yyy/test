// To parse this JSON data, do
//
//     final bankRes = bankResFromJson(jsonString);

import 'dart:convert';

BankRes bankResFromJson(String str) => BankRes.fromJson(json.decode(str));

String bankResToJson(BankRes data) => json.encode(data.toJson());

class BankRes {
  BankRes({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  String? status;
  List<Datum>? data;

  factory BankRes.fromJson(Map<String, dynamic> json) => BankRes(
        message: json["message"],
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.code,
    this.name,
  });

  int? id;
  String? code;
  String? name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
      };
}
