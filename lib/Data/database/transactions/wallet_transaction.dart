import 'package:hive/hive.dart';

part 'wallet_transaction.g.dart';

@HiveType(typeId: 2)
class TransactionDataBase extends HiveObject {
  @HiveField(0)
  String? transactionRef;
  @HiveField(1)
  String? description;
  @HiveField(2)
  String? direction;
  @HiveField(3)
  num? amount;
  @HiveField(4)
  num? balanceBeforeTransaction;
  @HiveField(5)
  num? balanceAfterTransaction;
  @HiveField(6)
  DateTime? createdAt;
  @HiveField(7)
  DateTime? updatedAt;
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
  @HiveField(18)
  String? firstName;
  @HiveField(19)
  String? lastName;
  @HiveField(20)
  String? accountNumber;
}
