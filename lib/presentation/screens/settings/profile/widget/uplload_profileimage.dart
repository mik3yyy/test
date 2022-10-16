import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/upload_pp_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/pick_image_dialog.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

class UploadImage extends StatefulHookConsumerWidget {
  final bool hasIcon;
  const UploadImage({Key? key, required this.hasIcon}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadImageState();
}

class _UploadImageState extends ConsumerState<UploadImage> {
  @override
  Widget build(BuildContext context) {
    final profileImage = PreferenceManager.avatarUrl;
    final image = ref.watch(userPhotoProvider);

    ref.listen<RequestState>(userPhotoProvider, (_, value) {
      if (value is Success) {
        // return ref.refresh(getProfileProvider);
      }
      if (value is Error) {
        // return AppSnackBar.showErrorSnackBar(context,
        //     message: value.error.toString());
      }
    });
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 42, top: 42),
          child: Transform.scale(
              scale: 3.3,
              child: image is Loading
                  ? const CircularProgressIndicator(
                      strokeWidth: 1.5,
                      color: Colors.white24,
                    )
                  : const SizedBox.shrink()),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 5, top: 5),
            child: profileImage.isNotEmpty
                ? CircleAvatar(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.transparent,
                    radius: 60.w,
                    backgroundImage: FileImage(File(profileImage)),
                    child: Stack(children: [
                      widget.hasIcon
                          ? InkWell(
                              onTap: () async {
                                PickImageDialog().pickImage(context, () {
                                  getImage(ImageSource.camera);
                                }, () {
                                  getImage(ImageSource.gallery);
                                });
                              },
                              child: const Align(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                  radius: 18.0,
                                  child: Icon(Icons.camera_alt_outlined,
                                      size: 18, color: Colors.white),
                                ),
                              ),
                            )
                          : const SizedBox.expand()
                    ]),
                  )
                : CircleAvatar(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.transparent,
                    radius: 60.w,
                    backgroundImage: const AssetImage(AppImage.profile),
                    child: Stack(children: [
                      widget.hasIcon
                          ? InkWell(
                              onTap: () async {
                                PickImageDialog().pickImage(context, () {
                                  getImage(ImageSource.camera);
                                }, () {
                                  getImage(ImageSource.gallery);
                                });
                              },
                              child: const Align(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                  radius: 18.0,
                                  // backgroundColor: AppColors.primaryColor.withOpacity(0.7),
                                  child: Icon(Icons.camera_alt_outlined,
                                      size: 18, color: Colors.white),
                                ),
                              ))
                          : const SizedBox.shrink()
                    ]),
                  )),
      ],
    );
  }

  void getImage(
    ImageSource imageSource,
  ) async {
    final _picker = ImagePicker();
    if (Platform.isAndroid) {}

    final XFile? image = await _picker.pickImage(source: imageSource);

    if (image == null) {
      return;
    }

    final imageFile = File(image.path);

    // selectedValue = imageFile;

    ref.read(userPhotoProvider.notifier).uploadProfilePhoto(image.path);

    final appDir = await path_provider.getApplicationDocumentsDirectory();

    // This is the saved image path
    // You can use it to display the saved image later
    final localPath = path.join(appDir.path, imageFile.path);
    PreferenceManager.avatarUrl = localPath;

    // print("I PRINTED PROFILEIMAGE $localPath");
  }
}
