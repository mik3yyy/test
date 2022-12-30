import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';

import '../../wallet/vm/get_account_details_vm.dart';

final providers = Provider((ref) {
  ref.invalidate(getAccountDetailsProvider);
  ref.invalidate(userProfileProvider);
  return PreferenceManager.isFirstLaunch = false;
});
