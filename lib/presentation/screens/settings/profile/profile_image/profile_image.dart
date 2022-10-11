import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/profile_image/select_image_dialog.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/providers.dart';

class ProfileImage extends HookConsumerWidget {
  final bool ignoreClick;
  final bool hasIcon;
  final double height;
  final double avatar;
  final double width;
  const ProfileImage(
      {Key? key,
      required this.ignoreClick,
      required this.hasIcon,
      this.height = 95,
      this.avatar = 30,
      this.width = 95})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    // final avatar = PreferenceManager.userAvatarUrl;
    // final upload = ref.watch(uploadFileState);
    final userAvatar = ref.watch(profileImage.state);
    final user = ref.watch(userProfileProvider);

    return AbsorbPointer(
      absorbing: ignoreClick,
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => const SelectImageType());
            },
            child: userAvatar.state.isNotEmpty
                ? CircleAvatar(
                    radius: avatar,
                    backgroundImage: FileImage(File(userAvatar.state)),
                  )
                : SizedBox(
                    height: height,
                    width: width,
                    child: user.value?.data.user.profilePicture == null
                        ? SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.asset(
                              AppImage.profile,
                              scale: 5,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(300.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => SizedBox(
                                height: 50,
                                width: 50,
                                child: Image.asset(
                                  AppImage.profile,
                                  scale: 5,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              imageUrl: user
                                  .value!.data.user.profilePicture!.imageUrl
                                  .toString(),
                            ),
                          ),
                  ),
          ),
          hasIcon
              ? const Padding(
                  padding: EdgeInsets.only(left: 60, top: 65),
                  child: CircleAvatar(
                    radius: 18.0,
                    child: Icon(Icons.camera_alt_outlined,
                        size: 18, color: Colors.white),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),

      // CircleAvatar(
      //     radius: blockH * 9,
      //     backgroundImage: FileImage(File(avatar)),
      //     child: upload is Loading
      //         ? BackdropFilter(
      //             filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
      //             child: Container(
      //                 decoration: BoxDecoration(
      //                     shape: BoxShape.circle,
      //                     color: Colors.white.withOpacity(0.0))))
      //         : const SizedBox.shrink(),
      //   )

      //   ),
    );
  }
}
