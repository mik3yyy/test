// To parse this JSON data, do
//
//     final countryRes = countryResFromJson(jsonString);

import 'dart:convert';

CountryRes countryResFromJson(String str) =>
    CountryRes.fromJson(json.decode(str));

String countryResToJson(CountryRes data) => json.encode(data.toJson());

class CountryRes {
  CountryRes({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  String? status;
  Data? data;

  factory CountryRes.fromJson(Map<String, dynamic> json) => CountryRes(
        message: json["message"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.countries,
  });

  List<Country>? countries;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        countries: List<Country>.from(
            json["countries"].map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "countries": List<dynamic>.from(countries!.map((x) => x.toJson())),
      };
}

class Country {
  Country({
    this.id,
    this.name,
    this.continent,
    this.allowWithdrawals,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  Continent? continent;
  int? allowWithdrawals;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        continent: continentValues.map[json["continent"]],
        allowWithdrawals: json["allow_withdrawals"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "continent": continentValues.reverse[continent],
        "allow_withdrawals": allowWithdrawals,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

enum Continent {
  // ignore: constant_identifier_names
  ASIA,
  // ignore: constant_identifier_names
  EUROPE,
  // ignore: constant_identifier_names
  AFRICA,
  // ignore: constant_identifier_names
  OCEANIA,
  // ignore: constant_identifier_names
  NORTH_AMERICA,
  // ignore: constant_identifier_names
  ANTARCTICA,
  // ignore: constant_identifier_names
  SOUTH_AMERICA
}

final continentValues = EnumValues({
  "Africa": Continent.AFRICA,
  "Antarctica": Continent.ANTARCTICA,
  "Asia": Continent.ASIA,
  "Europe": Continent.EUROPE,
  "North America": Continent.NORTH_AMERICA,
  "Oceania": Continent.OCEANIA,
  "South America": Continent.SOUTH_AMERICA
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => MapEntry(v, k));
    }
    return reverseMap;
  }
}
