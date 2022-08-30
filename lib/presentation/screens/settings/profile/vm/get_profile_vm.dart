import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/database/user_database.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/profile_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/profile/repo/profile_repository.dart';

import '../../../../../Data/controller/controller/generic_state_notifier.dart';

final getProfileProvider =
    StateNotifierProvider.autoDispose<GetProfileVM, RequestState<ProfileRes>>(
        (ref) {
  ref.maintainState = true;
  return GetProfileVM(ref);
});

class GetProfileVM extends RequestStateNotifier<ProfileRes> {
  final ProfileRepository _profileRepository;

  GetProfileVM(Ref ref)
      : _profileRepository = ref.read(profilehManagerProvider) {
    getProfile();
  }

  Future<RequestState<ProfileRes>> getProfile() =>
      makeRequest(() => _profileRepository.getPrfileDetails());
}

final userInfo = FutureProvider.autoDispose((ref) {
  ref.maintainState = true;

  return ref.watch(profilehManagerProvider).getPrfileDetails();
});

final userProfileProvider = FutureProvider.autoDispose((ref) {
  ref.maintainState = true;
  return ref.watch(profilehManagerProvider).getPrfileDetails();
});
