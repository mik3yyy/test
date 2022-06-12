import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/req/update_profile_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/profile_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/profile/repo/i_profile_repository.dart';

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
    return res;
  }

  // update profile
  @override
  Future<bool> updatePrfileDetails(
      {required UpdateProfileReq updateProfileReq}) async {
    final res = await _profileService.updatePrfileDetails(updateProfileReq);
    return res;
  }
}
