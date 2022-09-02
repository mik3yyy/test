import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';

final togglePinStateProvider = StateProvider<bool>((ref) {
  return PreferenceManager.enableTransactionBioMetrics;
});

final setPinStateProvider = StateProvider<bool>((ref) {
  return false;
});
