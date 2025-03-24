import 'package:image_picker/image_picker.dart';

class ImageUploadService {
  static Future<List<XFile>> pickMultipleImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    return images;
  }
}
