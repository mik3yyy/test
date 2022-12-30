import 'dart:async';
import 'dart:developer';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/app_session/session_config.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/app_session/session_timeout_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';

final appSessionConfigProvider = Provider<SessionConfig>((ref) {
  final sessionConfig = SessionConfig(
      invalidateSessionForAppLostFocus: const Duration(minutes: 2),
      invalidateSessionForUserInactivity: const Duration(minutes: 12));
  sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
    if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
      // handle user  inactive timeout
      if (PreferenceManager.isloggedIn == true) {
        // stop listening, as user will already be in auth page
        ref.read(sessionStateStreamProvider).add(SessionState.stopListening);
        navigator.key.currentContext!.navigateReplaceRoot(const SigninScreen());
        PreferenceManager.clear();

        log("INACTIVE");
      } else {
        return;
      }
    } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
      // handle user  app lost focus timeout
      if (PreferenceManager.isloggedIn == true) {
        // stop listening, as user will already be in auth page
        ref.read(sessionStateStreamProvider).add(SessionState.stopListening);
        navigator.key.currentContext!.navigateReplaceRoot(const SigninScreen());
        PreferenceManager.clear();
        log("APPFOCUS");
      } else {
        return;
      }
    }
  });
  return sessionConfig;
});

/// Firebase Analytics Provider

// final analyticsProvider = Provider((ref) {
//   return FirebaseAnalytics
// });

final sessionStateStreamProvider = Provider((ref) {
  return StreamController<SessionState>();
});
