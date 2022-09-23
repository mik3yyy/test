import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/Data/database/hive_setup.dart';
import 'package:kayndrexsphere_mobile/Data/utils/app_config/environment.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';

Future<void> initializeCore({required Environment environment}) async {
  AppConfig.environment = environment;
  await DataBase.init();
  await PreferenceManager.init();
  Stripe.publishableKey = Constants.stripePublishableKey;
  // Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  await Stripe.instance.applySettings();
}
