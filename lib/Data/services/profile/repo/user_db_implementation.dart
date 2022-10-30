import 'package:hive_flutter/hive_flutter.dart';
import 'package:kayndrexsphere_mobile/Data/database/user/user_database.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/profile_res.dart';

class UserDB {
  final userDb = Hive.box<UserDataBase>("user");

  void addUser(ProfileRes profile) {
    var user = UserDataBase()
      ..firstName = profile.data.user.firstName!
      ..lastName = profile.data.user.lastName!
      ..email = profile.data.user.email!
      ..gender = profile.data.user.gender!
      ..accountNumber = profile.data.user.accountNumber!
      ..country = profile.data.user.countryName!
      ..city = profile.data.user.city!
      ..state = profile.data.user.state!
      ..refCode = profile.data.user.refCode!
      ..address = profile.data.user.address
      ..dateOfBirth = profile.data.user.dateOfBirth
      ..countryCode = profile.data.defaultWallet.currencyCode
      ..balance = profile.data.defaultWallet.balance
      ..imageUrl = profile.data.user.profilePicture?.imageUrl
      ..phoneNumer = profile.data.user.phoneNumber!.phoneNumber;

    if (userDb.isEmpty) {
      userDb.add(user);
    } else {
      userDb.putAt(0, user);
      return;
    }
  }
}
