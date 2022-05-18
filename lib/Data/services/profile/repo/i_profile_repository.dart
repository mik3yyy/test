import '../../../model/profile/req/update_profile_req.dart';
import '../../../model/profile/res/profile_res.dart';

abstract class IProfileManager {
  Future<ProfileRes> getPrfileDetails();
  Future<bool> updatePrfileDetails(
      {required UpdateProfileReq updateProfileReq});
}
