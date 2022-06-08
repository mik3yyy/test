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
    required this.data,
  });

  String? message;
  String? status;
  Data data;

  factory CountryRes.fromJson(Map<String, dynamic> json) => CountryRes(
        message: json["message"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.countries,
  });

  List<Country> countries;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        countries: List<Country>.from(
            json["countries"].map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
      };
}

class Country {
  Country({
    this.id,
    this.name,
    this.iso2,
    this.continent,
    this.subRegion,
    this.currencyCode,
    this.allowWithdrawals,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? iso2;
  Continent? continent;
  String? subRegion;
  String? currencyCode;
  int? allowWithdrawals;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        iso2: json["iso2"],
        continent: continentValues.map![json["continent"]],
        subRegion: json["sub_region"],
        currencyCode: json["currency_code"],
        allowWithdrawals: json["allow_withdrawals"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "iso2": iso2,
        "continent": continentValues.reverse![continent],
        "sub_region": subRegion,
        "currency_code": currencyCode,
        "allow_withdrawals": allowWithdrawals,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

enum Continent { asia, europe, africa, oceania, americas, polar, empty }

final continentValues = EnumValues({
  "Africa": Continent.africa,
  "Americas": Continent.americas,
  "Asia": Continent.asia,
  "": Continent.empty,
  "Europe": Continent.europe,
  "Oceania": Continent.oceania,
  "Polar": Continent.polar
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
