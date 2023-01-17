import 'dart:io';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/upload_pp_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/providers.dart';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

final uploadImageProvider = Provider((ref) {
  return UploadImage(ref);
});

class UploadImage {
  final Ref ref;

  UploadImage(
    this.ref,
  );
  void getImage(
    ImageSource imageSource,
  ) async {
    try {
      final _picker = ImagePicker();
      if (Platform.isAndroid) {}

      final XFile? image = await _picker.pickImage(
          source: imageSource, preferredCameraDevice: CameraDevice.front);

      if (image == null) {
        return;
      }

      final imageFile = File(image.path);
      ref.read(userPhotoProvider.notifier).uploadProfilePhoto(image.path);
      final appDir = await path_provider.getApplicationDocumentsDirectory();

      /// convert to jpg

      // This is the saved image path
      // You can use it to display the saved image later
      final localPath = path.join(appDir.path, imageFile.path);
      PreferenceManager.avatarUrl = localPath;
      ref.read(profileImage.notifier).state = imageFile.path;
    } on PlatformException catch (e) {
      throw e.toString();
    }

    // print("I PRINTED PROFILEIMAGE $localPath");
  }
}
