import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/database/user/user_database.dart';

class UserProfileNotifier extends StateNotifier<UserDataBase> {
  final Ref ref;
  UserProfileNotifier(this.ref) : super(UserDataBase());

  void getUserDb() {
    final userdb = Hive.box<UserDataBase>("user");

    if (userdb.isEmpty) {
      return;
    } else {
      final user = userdb.values.toList().cast<UserDataBase>().first;

      state = user;
    }
  }
}

final savedUserProvider =
    StateNotifierProvider<UserProfileNotifier, UserDataBase>((ref) {
  return UserProfileNotifier(ref);
});
