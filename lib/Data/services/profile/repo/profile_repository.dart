import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/req/change_email_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/new_sign_in_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/req/change_password_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/req/change_transactionpin_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/req/update_profile_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/profile_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/saved_id.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/security_question_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/upload_id_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/profile/image/convert_image.dart';
import 'package:kayndrexsphere_mobile/Data/services/profile/repo/i_profile_repository.dart';
import 'package:kayndrexsphere_mobile/Data/services/profile/repo/user_db_implementation.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';

import '../profile_service.dart';

final profilehManagerProvider = Provider<ProfileRepository>((ref) {
  final profileService = ref.watch(profileProvider);

  return ProfileRepository(profileService);
});

class ProfileRepository extends IProfileManager {
  final ProfileService _profileService;

  ProfileRepository(this._profileService);

  // getprofile
  @override
  Future<ProfileRes> getPrfileDetails() async {
    final res = await _profileService.getPrfileDetails();

    PreferenceManager.defaultWallet =
        res.data.defaultWallet.currencyCode.toString();

    if (res.data.user.profilePicture?.imageUrl != null) {
      SaveImage.download(res.data.user.profilePicture!.imageUrl.toString());
    } else {}
    //ADD USER PROFILE TO OFFLINE DATABASE
    UserDB().addUser(res);
    return res;
  }

  // update profile
  @override
  Future<bool> updatePrfileDetails(
      {required UpdateProfileReq updateProfileReq}) async {
    final res = await _profileService.updatePrfileDetails(updateProfileReq);
    return res;
  }

// change password
  @override
  Future<bool> changePassword(ChangePasswordReq changePasswordReq) async {
    final res = await _profileService.changePassword(changePasswordReq);
    return res;
  }

// change transaction pin
  @override
  Future<bool> changeTransactionPin(
      ChangeTransactionPinReq changeTransactionPinReq) async {
    final res =
        await _profileService.changeTransactionPin(changeTransactionPinReq);
    return res;
  }

// forgot pin
  @override
  Future<bool> forgotPin(String emailPhone) async {
    final res = await _profileService.forgotPin(emailPhone);
    return res;
  }

// reset pin
  @override
  Future<bool> resetPin(String otpCode, String pin, String confirmPin) async {
    final res = await _profileService.resetPin(otpCode, pin, confirmPin);
    return res;
  }

  @override
  Future<bool> updateProfilePic({required String path}) async {
    final res = await _profileService.updateImage(path);
    return res;
  }

// upload Id
  @override
  Future<UploadIdRes> updateId(
      String filePath, String idType, String idNo) async {
    final res = await _profileService.updateId(filePath, idType, idNo);
    return res;
  }

  @override
  Future<SavedId> getID() async => await _profileService.getID();

  @override
  Future<UploadIdRes> editId(String filePath, String idType, String idNo,
          String id, bool isEdit) async =>
      await _profileService.editId(filePath, idType, idNo, id, isEdit);

  @override
  Future<UploadIdRes> deleteId(String id) async =>
      await _profileService.deleteId(id);

  @override
  Future<GenericRes> changeEmail(ChangeEmailReq changeEmailReq) async =>
      await _profileService.changeEmail(changeEmailReq);

  @override
  Future<GenericRes> verifyChangeEmail2FA(String code) async =>
      await _profileService.verifyChangeEmail2FA(code);

  @override
  Future<GenericRes> resendEmailChangeCode(String email) async =>
      await _profileService.resendEmailChangeCode(email);

  @override
  Future<GenericRes> securityQuestion(SecurityQuesReq securityQuesReq) async =>
      await _profileService.securityQuestion(securityQuesReq);
}
