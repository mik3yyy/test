import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:kayndrexsphere_mobile/Data/database/hive_setup.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/profile_res.dart';
import 'package:kayndrexsphere_mobile/Data/utils/app_config/environment.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';

final locator = GetIt.instance;
final newUser = jsonDecode(PreferenceManager.appUser);

Future<void> initializeCore({required Environment environment}) async {
  AppConfig.environment = environment;
  await DataBase.init();
  await PreferenceManager.init();
  await _initUser();
  // Stripe.publishableKey = Constants.stripePublishableKey;
  // // Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  // await Stripe.instance.applySettings();
}

Future<void> _initUser() async {
  locator.registerLazySingleton<ProfileRes>(() => ProfileRes.fromJson(newUser));
}
