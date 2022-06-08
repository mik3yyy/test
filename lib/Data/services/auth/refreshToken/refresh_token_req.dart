// To parse this JSON data, do
//
//     final refreshTokenReq = refreshTokenReqFromJson(jsonString);

import 'dart:convert';

RefreshTokenReq refreshTokenReqFromJson(String str) =>
    RefreshTokenReq.fromJson(json.decode(str));

String refreshTokenReqToJson(RefreshTokenReq data) =>
    json.encode(data.toJson());

class RefreshTokenReq {
  RefreshTokenReq({
    this.refreshToken,
    this.deviceId,
  });

  String? refreshToken;
  String? deviceId;

  factory RefreshTokenReq.fromJson(Map<String, dynamic> json) =>
      RefreshTokenReq(
        refreshToken: json["refresh_token"],
        deviceId: json["device_id"],
      );

  Map<String, dynamic> toJson() => {
        "refresh_token": refreshToken,
        "device_id": deviceId,
      };
}
