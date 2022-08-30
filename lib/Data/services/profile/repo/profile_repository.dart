import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/req/change_password_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/req/change_transactionpin_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/req/update_profile_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/profile_res.dart';
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

  // @override
  // Future upLoadProfilePic(String filePath) async {
  //   final res = await _profileService.upLoadProfilePic(filePath);
  //   return res;
  // }

  // @override
  // Future<bool> uploadPP(String imageUrl) async {
  //   final res = await _profileService.uploadPP(imageUrl);
  //   return res;
  // }
}
