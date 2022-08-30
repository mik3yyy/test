import 'package:hive_flutter/hive_flutter.dart';
import 'package:kayndrexsphere_mobile/Data/database/user_database.dart';

class DataBase {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserDataBaseAdapter());
    await Hive.openBox<UserDataBase>("user");
  }
}
