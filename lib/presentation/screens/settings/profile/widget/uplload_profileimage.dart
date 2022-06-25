import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/upload_pp_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/pick_image_dialog.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

class UploadImage extends StatefulHookConsumerWidget {
  const UploadImage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends ConsumerState<UploadImage> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(getProfileProvider);
    final profileImage = PreferenceManager.avatarUrl;
    // final selectedImage = ValueNotifier<File>(File(''));
    final selectedImage = useState<File>(File(''));
    bool isPicked = false;
    // ref.listen<RequestState>(userPhotoProvider, (T, value) {
    //   if (value is Success) {
    //     ref
    //         .read(uploadImageProvider.notifier)
    //         .upLoadImage(value.value!.secureUrl);
    //   }
    // });

    ref.listen<RequestState>(userPhotoProvider, (_, value) {
      if (value is Success) {
        ref.refresh(getProfileProvider);
        return AppSnackBar.showSuccessSnackBar(context,
            message: 'Profile Photo updated.');
      }
      if (value is Error) {
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });
    return profileImage.isNotEmpty
        ? CircleAvatar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            radius: 60.w,
            backgroundImage: FileImage(File(profileImage)),
            child: Stack(children: [
              InkWell(
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
                ),
              ),
            ]),
          )
        : CircleAvatar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            radius: 60.w,
            backgroundImage: const AssetImage("images/person.png"),
            child: Stack(children: [
              InkWell(
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
                ),
              ),
            ]),
          );

    // return vm.when(
    //     error: (error, stackTrace) => Text(error.toString()),
    //     loading: () => CircleAvatar(
    //           backgroundColor: Colors.transparent,
    //           foregroundColor: Colors.transparent,
    //           radius: 45,
    //           child: Image.asset("images/person.png", color: Colors.white),
    //         ),
    //     idle: () => CircleAvatar(
    //           backgroundColor: Colors.transparent,
    //           foregroundColor: Colors.transparent,
    //           radius: 45,
    //           child: Stack(children: [
    //             InkWell(
    //               onTap: () async {
    //                 final _picker = ImagePicker();
    //                 final XFile? image =
    //                     await _picker.pickImage(source: ImageSource.gallery);
    //                 ref
    //                     .read(userPhotoProvider.notifier)
    //                     .uploadProfilePhoto(image!.path);
    //                 selectedImage.value = File(image.path);
    //               },
    //               child: const Align(
    //                 alignment: Alignment.bottomRight,
    //                 child: CircleAvatar(
    //                   radius: 18.0,
    //                   // backgroundColor: AppColors.primaryColor.withOpacity(0.7),
    //                   child: Icon(Icons.camera_alt_outlined,
    //                       size: 18, color: Colors.white),
    //                 ),
    //               ),
    //             ),
    //           ]),
    //         ),
    //     success: (data) {
    //       return CircleAvatar(
    //         radius: 45.0,
    //         backgroundImage:
    //             // const AssetImage("images/person.png"),

    //             data!.data.user.profilePicture?.imageUrl.toString() == ""
    //                 ? const AssetImage("images/person.png")
    //                 : AssetImage(data.data.user.profilePicture?.imageUrl ??
    //                     "images/person.png"),
    //         child: Stack(children: [
    //           InkWell(
    //             onTap: () async {
    //               final _picker = ImagePicker();
    //               final XFile? image =
    //                   await _picker.pickImage(source: ImageSource.gallery);
    //               ref
    //                   .read(userPhotoProvider.notifier)
    //                   .uploadProfilePhoto(image!.path);
    //               selectedImage.value = File(image.path);
    //             },
    //             child: const Align(
    //               alignment: Alignment.bottomRight,
    //               child: CircleAvatar(
    //                 radius: 18.0,
    //                 // backgroundColor: AppColors.primaryColor.withOpacity(0.7),
    //                 child: Icon(Icons.camera_alt_outlined,
    //                     size: 18, color: Colors.white),
    //               ),
    //             ),
    //           ),
    //         ]),
    //       );
    //     });
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

    final appDir = await path_provider.getApplicationDocumentsDirectory();

    // This is the saved image path
    // You can use it to display the saved image later
    final localPath = path.join(appDir.path, imageFile.path);
    PreferenceManager.avatarUrl = localPath;

    // print("I PRINTED PROFILEIMAGE $localPath");

    ref.read(userPhotoProvider.notifier).uploadProfilePhoto(image.path);
  }
}
