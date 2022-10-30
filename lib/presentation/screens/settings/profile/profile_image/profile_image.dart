import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/profile_image/select_image_dialog.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/user_profile/user_profile_db.dart';
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
    final savedUser = ref.watch(savedUserProvider);

    return AbsorbPointer(
      absorbing: ignoreClick,
      child: Stack(
        children: [
          userAvatar.state.isNotEmpty
              ? CircleAvatar(
                  radius: avatar,
                  backgroundImage: FileImage(File(userAvatar.state)),
                )
              : SizedBox(
                  height: height,
                  width: width,
                  child: savedUser.imageUrl == null
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
                          child: KYNetworkImage(
                            url: savedUser.imageUrl.toString(),
                            errorImage: Image.asset(
                              AppImage.profile,
                              scale: 5,
                              fit: BoxFit.cover,
                            ),
                            fit: BoxFit.cover,
                          )),
                ),
          hasIcon
              ? InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => const SelectImageType());
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 60, top: 65),
                    child: CircleAvatar(
                      radius: 18.0,
                      child: Icon(Icons.camera_alt_outlined,
                          size: 18, color: Colors.white),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class KYNetworkImage extends StatelessWidget {
  final String url;
  final Widget errorImage;
  final BoxFit fit;
  final double height;
  final double width;
  const KYNetworkImage(
      {Key? key,
      required this.url,
      required this.errorImage,
      required this.fit,
      this.height = 50.0,
      this.width = 50.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => SizedBox(
        height: 50,
        width: 50,
        child: errorImage,
      ),
      imageUrl: url,
    );
  }
}
