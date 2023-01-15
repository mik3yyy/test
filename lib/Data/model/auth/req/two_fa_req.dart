import 'dart:convert';

String the2FaReqToJson(The2FaReq? data) => json.encode(data!.toJson());

class The2FaReq {
  The2FaReq({
    this.email,
    this.code,
  });

  String? email;
  String? code;

  Map<String, dynamic> toJson() => {
        "email": email,
        "code": code,
      };
}
