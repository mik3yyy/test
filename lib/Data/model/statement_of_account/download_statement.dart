// To parse this JSON data, do
//
//     final statementOfAccount = statementOfAccountFromJson(jsonString);

import 'dart:convert';

DownloadStatement downloadStatementFromJson(String str) =>
    DownloadStatement.fromJson(json.decode(str));

String downloadStatementToJson(DownloadStatement data) =>
    json.encode(data.toJson());

class DownloadStatement {
  DownloadStatement({
    this.message,
    this.status,
  });

  String? message;
  String? status;

  factory DownloadStatement.fromJson(Map<String, dynamic> json) =>
      DownloadStatement(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
