// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionDataBaseAdapter extends TypeAdapter<TransactionDataBase> {
  @override
  final int typeId = 2;

  @override
  TransactionDataBase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionDataBase()
      ..transactionRef = fields[0] as String?
      ..description = fields[1] as String?
      ..direction = fields[2] as String?
      ..amount = fields[3] as num?
      ..balanceBeforeTransaction = fields[4] as num?
      ..balanceAfterTransaction = fields[5] as num?
      ..createdAt = fields[6] as DateTime?
      ..updatedAt = fields[7] as DateTime?
      ..countryCode = fields[8] as String?
      ..isBanned = fields[9] as num?
      ..refCode = fields[10] as String?
      ..dateOfBirth = fields[11] as DateTime?
      ..phoneNumer = fields[12] as String?
      ..address = fields[13] as String?
      ..balance = fields[14] as String?
      ..defaultWalletBalance = fields[15] as num?
      ..defaultWalletCode = fields[16] as String?
      ..imageUrl = fields[17] as String?
      ..firstName = fields[18] as String?
      ..lastName = fields[19] as String?
      ..accountNumber = fields[20] as String?;
  }

  @override
  void write(BinaryWriter writer, TransactionDataBase obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.transactionRef)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.direction)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.balanceBeforeTransaction)
      ..writeByte(5)
      ..write(obj.balanceAfterTransaction)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt)
      ..writeByte(8)
      ..write(obj.countryCode)
      ..writeByte(9)
      ..write(obj.isBanned)
      ..writeByte(10)
      ..write(obj.refCode)
      ..writeByte(11)
      ..write(obj.dateOfBirth)
      ..writeByte(12)
      ..write(obj.phoneNumer)
      ..writeByte(13)
      ..write(obj.address)
      ..writeByte(14)
      ..write(obj.balance)
      ..writeByte(15)
      ..write(obj.defaultWalletBalance)
      ..writeByte(16)
      ..write(obj.defaultWalletCode)
      ..writeByte(17)
      ..write(obj.imageUrl)
      ..writeByte(18)
      ..write(obj.firstName)
      ..writeByte(19)
      ..write(obj.lastName)
      ..writeByte(20)
      ..write(obj.accountNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionDataBaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
