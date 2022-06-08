// To parse this JSON data, do
//
//     final getBankAccountDetails = getBankAccountDetailsFromJson(jsonString);

import 'dart:convert';

GetBankAccountDetails getBankAccountDetailsFromJson(String str) =>
    GetBankAccountDetails.fromJson(json.decode(str));

String getBankAccountDetailsToJson(GetBankAccountDetails data) =>
    json.encode(data.toJson());

class GetBankAccountDetails {
  GetBankAccountDetails({
    this.bankCode,
    this.accountNumber,
  });

  String? bankCode;
  String? accountNumber;

  factory GetBankAccountDetails.fromJson(Map<String, dynamic> json) =>
      GetBankAccountDetails(
        bankCode: json["bank_code"],
        accountNumber: json["account_number"],
      );

  Map<String, dynamic> toJson() => {
        "bank_code": bankCode,
        "account_number": accountNumber,
      };
}
