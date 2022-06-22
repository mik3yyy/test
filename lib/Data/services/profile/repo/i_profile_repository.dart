import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/req/change_password_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/req/change_transactionpin_req.dart';

import '../../../model/profile/req/update_profile_req.dart';
import '../../../model/profile/res/profile_res.dart';

abstract class IProfileManager {
  Future<ProfileRes> getPrfileDetails();
  Future<bool> updatePrfileDetails(
      {required UpdateProfileReq updateProfileReq});
  Future<bool> changePassword(ChangePasswordReq changePasswordReq);
  Future<bool> changeTransactionPin(
      ChangeTransactionPinReq changeTransactionPinReq);
  Future<bool> forgotPin(String emailPhone);
  Future<bool> resetPin(String otpCode, String pin, String confirmPin);
  Future<CloudinaryResponse> upLoadProfilePic(String filePath);
  Future<bool> uploadPP(String imageUrl);
}