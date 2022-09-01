// To parse this JSON data, do
//
//     final stripeWebRes = stripeWebResFromJson(jsonString);

import 'dart:convert';

StripeWebRes stripeWebResFromJson(String str) =>
    StripeWebRes.fromJson(json.decode(str));

String stripeWebResToJson(StripeWebRes data) => json.encode(data.toJson());

class StripeWebRes {
  StripeWebRes({
    required this.url,
  });

  String url;

  factory StripeWebRes.fromJson(Map<String, dynamic> json) => StripeWebRes(
        url: json["url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
