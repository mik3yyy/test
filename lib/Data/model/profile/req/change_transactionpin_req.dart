// To parse this JSON data, do
//
//     final changeTransactionPinReq = changeTransactionPinReqFromJson(jsonString);

import 'dart:convert';

ChangeTransactionPinReq changeTransactionPinReqFromJson(String str) =>
    ChangeTransactionPinReq.fromJson(json.decode(str));

String changeTransactionPinReqToJson(ChangeTransactionPinReq data) =>
    json.encode(data.toJson());

class ChangeTransactionPinReq {
  ChangeTransactionPinReq({
    this.oldPin,
    this.newPin,
    this.confirmNewPin,
  });

  String? oldPin;
  String? newPin;
  String? confirmNewPin;

  factory ChangeTransactionPinReq.fromJson(Map<String, dynamic> json) =>
      ChangeTransactionPinReq(
        oldPin: json["old_pin"],
        newPin: json["new_pin"],
        confirmNewPin: json["confirm_new_pin"],
      );

  Map<String, dynamic> toJson() => {
        "old_pin": oldPin,
        "new_pin": newPin,
        "confirm_new_pin": confirmNewPin,
      };
}
