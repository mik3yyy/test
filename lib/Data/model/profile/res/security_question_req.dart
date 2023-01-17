// To parse this JSON data, do
//
//     final securityQuesReq = securityQuesReqFromJson(jsonString);

import 'dart:convert';

String securityQuesReqToJson(SecurityQuesReq? data) =>
    json.encode(data!.toJson());

class SecurityQuesReq {
  SecurityQuesReq({
    this.question,
    this.answer,
    this.hint,
  });

  String? question;
  String? answer;
  String? hint;

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
        "hint": hint,
      };
}
