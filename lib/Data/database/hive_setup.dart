import 'package:hive_flutter/hive_flutter.dart';
import 'package:kayndrexsphere_mobile/Data/database/user/user_database.dart';

class DataBase {
  static Future<void> init() async {
    await Hive.initFlutter();

    ///USER DATABASE DB
    Hive.registerAdapter(UserDataBaseAdapter());
    await Hive.openBox<UserDataBase>("user");

    ///WALLET TRANSACTION DB
    // Hive.registerAdapter(TransactionDataBaseAdapter());
    // await Hive.openBox<TransactionDataBase>(Constants.transaction);
    // await Hive.deleteBoxFromDisk(Constants.transaction);
  }
}
