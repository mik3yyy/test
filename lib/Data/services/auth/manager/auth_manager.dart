import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/auth_service.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/i_auth_manager.dart';

final authManagerProvider = Provider<AuthManager>((ref) {
  final userService = ref.watch(userServiceProvider);

  return AuthManager(userService);
});

class AuthManager extends IAuthManager {
  final UserService _userService;

  AuthManager(this._userService);

  // @override
  // Future<AuthRes> register(RegisterReq register) async {
  //   final reg = await _userService.register(register);
  //   // return reg;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final isSaved = await prefs.setString(Constants.token, reg.data.token);
  //   if (isSaved) {
  //     return reg;
  //   }
  //   throw Exception(
  //       'An Error has occured while signing you in. Please contact support');
  // }

}
