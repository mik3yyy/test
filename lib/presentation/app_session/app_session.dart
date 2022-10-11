import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/app_session/session_config.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';

final appSessionConfigProvider = Provider<SessionConfig>((ref) {
  final sessionConfig = SessionConfig(
      invalidateSessionForAppLostFocus: const Duration(minutes: 2),
      invalidateSessionForUserInactiviity: const Duration(minutes: 12));
  sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
    if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
      // handle user  inactive timeout
      if (PreferenceManager.isloggedIn == true) {
        navigator.key.currentContext!.navigateReplaceRoot(const SigninScreen());
        PreferenceManager.clear();
        debugPrint("INACTIVE");
      } else {
        return;
      }
    } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
      // handle user  app lost focus timeout
      if (PreferenceManager.isloggedIn == true) {
        navigator.key.currentContext!.navigateReplaceRoot(const SigninScreen());
        PreferenceManager.clear();
        debugPrint("APPFOCUS");
      } else {
        return;
      }
    }
  });
  return sessionConfig;
});
