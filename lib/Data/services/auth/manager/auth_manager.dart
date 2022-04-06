import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/verify_account_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/auth_service.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/i_auth_manager.dart';

final authManagerProvider = Provider<AuthManager>((ref) {
  final userService = ref.watch(userServiceProvider);

  return AuthManager(userService);
});

class AuthManager extends IAuthManager {
  final UserService _userService;

  AuthManager(this._userService);

  // create account
  @override
  Future<bool> createAccount(
      {required String firstName,
      required String lastName,
      required emailPhone}) async {
    final res =
        await _userService.createAccount(firstName, lastName, emailPhone);
    return res;
  }

  // verify account
  @override
  Future<bool> verifyAccount(verify) async {
    final res = await _userService.verifyAccount(verify);
    return res;
  }
}
