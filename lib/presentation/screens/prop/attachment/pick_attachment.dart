import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

final fileProvider = Provider<Attachment>((ref) {
  return Attachment();
});

class Attachment {
  Future<String> addAttachment() async {
    try {
      FilePickerResult? file = await FilePicker.platform.pickFiles(
          type: FileType.any,
          // allowedExtensions: ['jpg', 'pdf', 'doc'],
          allowCompression: false);

      if (file == null) {
        return "";
      }
      final pickedFile = File(file.files.single.path!);
      final appDir = await path_provider.getApplicationDocumentsDirectory();
      final localPath = path.join(appDir.path, pickedFile.path);
      return localPath;
    } on PlatformException catch (e) {
      throw e.toString();
    }
  }
}
