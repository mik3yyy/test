import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/upload_pp_vm.dart';

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

    return vm.when(
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => CircleAvatar(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              radius: 45,
              child: Image.asset("images/person.png", color: Colors.white),
            ),
        idle: () => CircleAvatar(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              radius: 45,
              child: Image.asset("images/person.png", color: Colors.white),
            ),
        success: (data) {
          return CircleAvatar(
            radius: 45.0,
            backgroundImage: data!.data!.user!.profilePicture == ""
                ? const AssetImage("images/person.png")
                : AssetImage(data.data!.user!.profilePicture),
            child: Stack(children: [
              InkWell(
                onTap: () async {
                  final _picker = ImagePicker();
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  ref
                      .read(userPhotoProvider.notifier)
                      .uploadProfilePhoto(image!.path);
                  selectedImage.value = File(image.path);
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
        });

    // return ValueListenableBuilder(
    //     valueListenable: selectedImage,
    //     builder: (context, File imageFile, child) {
    //       return GestureDetector(
    //         onTap: () async {
    //           final _picker = ImagePicker();
    //           final XFile? image =
    //               await _picker.pickImage(source: ImageSource.gallery);

    //           if (image == null) {
    //             return;
    //           }
    //           // final imageFile = File(image.path);
    //           // selectedImage.value = imageFile;
    //           ref
    //               .read(userPhotoProvider.notifier)
    //               .uploadProfilePhoto(image.path);
    //           selectedImage.value = File(image.path);
    //         },
    //         child: selectedImage.value.existsSync() == isPicked
    //             ? Stack(
    //                 children: [
    //                   CircleAvatar(
    //                     radius: 50.r,
    //                     backgroundImage: const AssetImage(
    //                       AppImage.image1,
    //                     ),
    //                   ),
    //                   Positioned(
    //                     top: 35.h,
    //                     left: 31.w,
    //                     child: const Icon(
    //                       Icons.camera_alt_outlined,
    //                       color: AppColors.whiteColor,
    //                     ),
    //                   )
    //                 ],
    //               )
    //             : HookConsumer(
    //                 builder: (context, ref, child) {
    //                   final controller = ref.watch(userPhotoProvider);
    //                   final vm = ref.watch(getProfileProvider);
    //                   return controller is Loading
    //                       ? Stack(
    //                           children: [
    //                             CircleAvatar(
    //                               radius: 50.r,
    //                               // child: Image(
    //                               //   image: FileImage(imageFile),
    //                               //   fit: BoxFit.cover,
    //                               //   width: 100,
    //                               //   height: 100,
    //                               // ),
    // backgroundImage: Image.network(vm.maybeWhen(
    //         success: (v) =>
    //             v!.data!.user!.profilePicture,
    //         orElse: () =>
    //             'https://www.pngkey.com/png/full/52-522921_kathrine-vangen-profile-pic-empty-png.png')
    //     // .asData?.value?.imageLink ??
    //     ).image,
    //                             ),
    //                             Positioned(
    //                               top: 35.h,
    //                               left: 31.w,
    //                               child: const Icon(
    //                                 Icons.camera_alt_outlined,
    //                                 color: AppColors.whiteColor,
    //                               ),
    //                             )
    //                           ],
    //                         )
    //                       : Stack(
    //                           children: [
    //                             CircleAvatar(
    //                               radius: 50.r,
    //                               child: ClipRRect(
    //                                   borderRadius: BorderRadius.circular(50),
    //                                   child: Image(
    //                                     image: FileImage(imageFile),
    //                                     fit: BoxFit.cover,
    //                                     width: 100,
    //                                     height: 100,
    //                                   )),
    //                             ),
    //                             Positioned(
    //                               top: 35.h,
    //                               left: 31.w,
    //                               child: const Icon(
    //                                 Icons.camera_alt_outlined,
    //                                 color: AppColors.whiteColor,
    //                               ),
    //                             )
    //                           ],
    //                         );
    //                 },
    //               ),
    //       );
    //     });
  }
}
