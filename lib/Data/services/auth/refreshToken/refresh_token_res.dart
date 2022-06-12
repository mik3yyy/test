// To parse this JSON data, do
//
//     final refreshTokenRes = refreshTokenResFromJson(jsonString);

import 'dart:convert';

RefreshTokenRes refreshTokenResFromJson(String str) =>
    RefreshTokenRes.fromJson(json.decode(str));

String refreshTokenResToJson(RefreshTokenRes data) =>
    json.encode(data.toJson());

class RefreshTokenRes {
  RefreshTokenRes({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  String? status;
  Data? data;

  factory RefreshTokenRes.fromJson(Map<String, dynamic> json) =>
      RefreshTokenRes(
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
    this.authToken,
    this.refreshToken,
  });

  String? authToken;
  String? refreshToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        authToken: json["auth_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "auth_token": authToken,
        "refresh_token": refreshToken,
      };
}
