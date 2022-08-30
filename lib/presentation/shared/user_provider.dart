import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';

import '../../Data/model/profile/res/profile_res.dart';

final locator = GetIt.instance;
final newUser = jsonDecode(PreferenceManager.appUser);
// final user = newUser;

Future<void> initialize() async {
  _initUser();
}

void _initUser() {
  locator.registerLazySingleton<ProfileRes>(() => ProfileRes.fromJson(newUser));
}
