// To parse this JSON data, do
//
//     final forgettenEmailRes = forgettenEmailResFromJson(jsonString);

import 'dart:convert';

ForgettenEmailRes forgettenEmailResFromJson(String str) =>
    ForgettenEmailRes.fromJson(json.decode(str));

String forgettenEmailResToJson(ForgettenEmailRes data) =>
    json.encode(data.toJson());

class ForgettenEmailRes {
  ForgettenEmailRes({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data data;

  factory ForgettenEmailRes.fromJson(Map<String, dynamic> json) =>
      ForgettenEmailRes(
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
    required this.the2FaToken,
  });

  String the2FaToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        the2FaToken: json["2fa_token"],
      );

  Map<String, dynamic> toJson() => {
        "2fa_token": the2FaToken,
      };
}
