import '../../../model/auth/res/verify_account_res.dart';

abstract class IAuthManager {
  Future<bool> createAccount(
      {required String firstName,
      required String lastName,
      required emailPhone});
  Future<bool> verifyAccount(VerifyAccount verify);
}
