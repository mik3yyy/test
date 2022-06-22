import 'dart:io';
import 'dart:ui';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/upload_image_vm.dart';
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
    final selectedImage = ValueNotifier<File>(File(''));
    bool isPicked = false;
    ref.listen<RequestState>(uploadProfilePicProvider, (T, value) {
      if (value is Success<CloudinaryResponse>) {
        ref
            .read(uploadImageProvider.notifier)
            .upLoadImage(value.value!.secureUrl);
      }
    });
    return ValueListenableBuilder(
        valueListenable: selectedImage,
        builder: (context, File imageFile, child) {
          return GestureDetector(
            onTap: () async {
              final _picker = ImagePicker();
              final XFile? image =
                  await _picker.pickImage(source: ImageSource.gallery);

              if (image == null) {
                return;
              }
              final imageFile = File(image.path);
              selectedImage.value = imageFile;
              ref
                  .read(uploadProfilePicProvider.notifier)
                  .upLoadPP(FileImage(imageFile));
            },
            child: selectedImage.value.existsSync() == isPicked
                ? Stack(
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage: const AssetImage(
                          AppImage.image1,
                        ),
                      ),
                      Positioned(
                        top: 35.h,
                        left: 31.w,
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: AppColors.whiteColor,
                        ),
                      )
                    ],
                  )
                : HookConsumer(
                    builder: (context, ref, child) {
                      final controller = ref.watch(uploadProfilePicProvider);
                      return controller is Loading
                          ? Stack(
                              children: [
                                CircleAvatar(
                                  radius: 50.r,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 5, sigmaY: 5),
                                        child: Image(
                                          image: FileImage(imageFile),
                                          fit: BoxFit.cover,
                                          width: 100,
                                          height: 100,
                                        ),
                                      )),
                                ),
                                Positioned(
                                  top: 35.h,
                                  left: 31.w,
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: AppColors.whiteColor,
                                  ),
                                )
                              ],
                            )
                          : Stack(
                              children: [
                                CircleAvatar(
                                  radius: 50.r,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image(
                                        image: FileImage(imageFile),
                                        fit: BoxFit.cover,
                                        width: 100,
                                        height: 100,
                                      )),
                                ),
                                Positioned(
                                  top: 35.h,
                                  left: 31.w,
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: AppColors.whiteColor,
                                  ),
                                )
                              ],
                            );
                    },
                  ),
          );
        });
  }
}
