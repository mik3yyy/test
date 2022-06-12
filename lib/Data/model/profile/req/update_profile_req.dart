// To parse this JSON data, do
//
//     final updateProfileReq = updateProfileReqFromJson(jsonString);

import 'dart:convert';

UpdateProfileReq updateProfileReqFromJson(String str) =>
    UpdateProfileReq.fromJson(json.decode(str));

String updateProfileReqToJson(UpdateProfileReq data) =>
    json.encode(data.toJson());

class UpdateProfileReq {
  UpdateProfileReq({
    this.firstName,
    this.lastName,
    this.gender,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.country,
    this.state,
    this.city,
    this.address,
  });

  String? firstName;
  String? lastName;
  String? gender;
  String? email;
  String? phoneNumber;
  String? dateOfBirth;
  String? country;
  String? state;
  String? city;
  String? address;

  factory UpdateProfileReq.fromJson(Map<String, dynamic> json) =>
      UpdateProfileReq(
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        dateOfBirth: json["date_of_birth"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "email": email,
        "phone_number": phoneNumber,
        "date_of_birth": dateOfBirth,
        "country": country,
        "state": state,
        "city": city,
        "address": address,
      };
}
