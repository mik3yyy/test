// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDataBaseAdapter extends TypeAdapter<UserDataBase> {
  @override
  final int typeId = 1;

  @override
  UserDataBase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDataBase()
      ..firstName = fields[0] as String?
      ..lastName = fields[1] as String?
      ..gender = fields[2] as String?
      ..accountNumber = fields[3] as String?
      ..email = fields[4] as String?
      ..city = fields[5] as String?
      ..state = fields[6] as String?
      ..country = fields[7] as String?
      ..countryCode = fields[8] as String?
      ..isBanned = fields[9] as num?
      ..refCode = fields[10] as String?
      ..dateOfBirth = fields[11] as DateTime?
      ..phoneNumer = fields[12] as String?
      ..address = fields[13] as String?;
  }

  @override
  void write(BinaryWriter writer, UserDataBase obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.gender)
      ..writeByte(3)
      ..write(obj.accountNumber)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.city)
      ..writeByte(6)
      ..write(obj.state)
      ..writeByte(7)
      ..write(obj.country)
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
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataBaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
