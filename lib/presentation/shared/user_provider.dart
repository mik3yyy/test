import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/signin_res.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';

final locator = GetIt.instance;
final newUser = jsonDecode(PreferenceManager.appUser);
final user = newUser;

Future<void> initialize() async {
  _initUser();
}

void _initUser() {
  locator.registerLazySingleton<SigninRes>(() => SigninRes.fromJson(newUser));
}
