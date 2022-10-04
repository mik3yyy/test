// To parse this JSON data, do
//
//     final statementReq = statementReqFromJson(jsonString);

import 'dart:convert';

String statementReqToJson(StatementReq data) => json.encode(data.toJson());

class StatementReq {
  StatementReq({
    this.fromDate,
    this.toDate,
  });

  String? fromDate;
  String? toDate;

  Map<String, dynamic> toJson() => {
        "from_date": fromDate,
        "to_date": toDate,
      };
}
