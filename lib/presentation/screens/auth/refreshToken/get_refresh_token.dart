import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:async/async.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/auth_manager.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/refreshToken/refresh_token_req.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

final getAuthUser = Provider((ref) {
  final authManagerService = ref.watch(authManagerProvider);
  return RefreshToken(authManagerService);
});

class RefreshToken {
  final AuthManager _authManager;
  RefreshToken(this._authManager);

  Future<void> getToken() async {
    final refreshToken = PreferenceManager.refreshToken;

    var refreshTokenReq = RefreshTokenReq(
        refreshToken: refreshToken, deviceId: "deviceIDSforlife");

    final RestartableTimer timer = RestartableTimer(
      const Duration(seconds: 1),
      () {
        'Timer ticked here'.log();
      },
    );
    await for (final value in Stream.periodic(
      const Duration(seconds: 3),
      // returnParameter,
    )) {
      timer.cancel();
      await Future.delayed(const Duration(seconds: 1));
      timer.reset();
    }

    RestartableTimer _timer =
        RestartableTimer((const Duration(seconds: 4)), () async {
      final token = await _authManager.getAuthTOken(refreshTokenReq);

      print("I GOT HERE");
    });
  }
}
