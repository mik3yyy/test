import 'package:hive/hive.dart';

part 'user_database.g.dart';

@HiveType(typeId: 1)
class UserDataBase extends HiveObject {
  @HiveField(0)
  String? firstName;
  @HiveField(1)
  String? lastName;
  @HiveField(2)
  String? gender;
  @HiveField(3)
  String? accountNumber;
  @HiveField(4)
  String? email;
  @HiveField(5)
  String? city;
  @HiveField(6)
  String? state;
  @HiveField(7)
  String? country;
  @HiveField(8)
  String? countryCode;
  @HiveField(9)
  num? isBanned;
  @HiveField(10)
  String? refCode;
  @HiveField(11)
  DateTime? dateOfBirth;
  @HiveField(12)
  String? phoneNumer;
  @HiveField(13)
  String? address;
  @HiveField(14)
  String? balance;
  @HiveField(15)
  num? defaultWalletBalance;
  @HiveField(16)
  String? defaultWalletCode;
  @HiveField(17)
  String? imageUrl;
}
