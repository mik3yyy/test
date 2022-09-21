import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import 'upload_image/upload_image.dart';

class SelectImageType extends HookConsumerWidget {
  const SelectImageType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
        title: const Text("Select Image location "),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SelectCameraType(
                    icon: const Icon(
                      Icons.photo_library,
                      size: 50,
                    ),
                    onPressed: () {
                      ref
                          .read(uploadImageProvider)
                          .getImage(ImageSource.gallery);
                      Navigator.pop(context);
                    }),
                const Space(20),
                SelectCameraType(
                    icon: const Icon(
                      Icons.photo_camera,
                      size: 50,
                    ),
                    onPressed: () {
                      ref
                          .read(uploadImageProvider)
                          .getImage(ImageSource.camera);

                      Navigator.pop(context);
                    }),
              ],
            ),
          ],
        ));
  }
}

class SelectCameraType extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;
  const SelectCameraType({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: Colors.grey.shade600)),
          child: icon),
    );
  }
}
