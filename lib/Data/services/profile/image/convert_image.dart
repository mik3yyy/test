import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

// final profileImageProvider = Provider((ref) {
//   return SaveImage();
// });

class SaveImage {
  static Future<String> download(String url) async {
    final response = await http.get(Uri.parse(url));

    // Get the image name
    final imageName = path.basename(url);
    // Get the document directory path
    final appDir = await path_provider.getApplicationDocumentsDirectory();

    // This is the saved image path
    // You can use it to display the saved image later
    final localPath = path.join(appDir.path, imageName);

    PreferenceManager.avatarUrl = localPath;

    // Downloading
    final imageFile = File(localPath);
    await imageFile.writeAsBytes(response.bodyBytes);
    return localPath;
  }
}
