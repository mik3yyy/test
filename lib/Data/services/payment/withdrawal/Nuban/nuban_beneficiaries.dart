// // To parse this JSON data, do
// //
// //     final nubanBeneficiariesRes = nubanBeneficiariesResFromJson(jsonString);

// import 'dart:convert';

// NubanBeneficiariesRes nubanBeneficiariesResFromJson(String str) =>
//     NubanBeneficiariesRes.fromJson(json.decode(str));

// String nubanBeneficiariesResToJson(NubanBeneficiariesRes data) =>
//     json.encode(data.toJson());

// class NubanBeneficiariesRes {
//   NubanBeneficiariesRes({
//     this.message,
//     this.status,
//     required this.data,
//   });

//   String? message;
//   String? status;
//   Data data;

//   factory NubanBeneficiariesRes.fromJson(Map<String, dynamic> json) =>
//       NubanBeneficiariesRes(
//         message: json["message"],
//         status: json["status"],
//         data: Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "status": status,
//         "data": data.toJson(),
//       };
// }

// class Data {
//   Data({
//     required this.beneficiaries,
//   });

//   List<Beneficiary> beneficiaries;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         beneficiaries: List<Beneficiary>.from(
//             json["beneficiaries"].map((x) => Beneficiary.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "beneficiaries":
//             List<dynamic>.from(beneficiaries.map((x) => x.toJson())),
//       };
// }

// class Beneficiary {
//   Beneficiary({
//     this.id,
//     this.accountType,
//     this.bankCode,
//     this.accountNumber,
//     this.accountName,
//     this.createdAt,
//     this.updatedAt,
//   });

//   int? id;
//   String? accountType;
//   String? bankCode;
//   String? accountNumber;
//   String? accountName;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   factory Beneficiary.fromJson(Map<String, dynamic> json) => Beneficiary(
//         id: json["id"],
//         accountType: json["account_type"],
//         bankCode: json["bank_code"],
//         accountNumber: json["account_number"],
//         accountName: json["account_name"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "account_type": accountType,
//         "bank_code": bankCode,
//         "account_number": accountNumber,
//         "account_name": accountName,
//         "created_at": createdAt!.toIso8601String(),
//         "updated_at": updatedAt!.toIso8601String(),
//       };
// }
