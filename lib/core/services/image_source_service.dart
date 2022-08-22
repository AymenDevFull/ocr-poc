import 'package:image_picker/image_picker.dart';

class ImagesSourceService {
  ImagesSourceService({
    required this.imagePicker,
  });
  final ImagePicker imagePicker;

  Future<String?> getImage(ImageSource source) async {
    try {
      final pickedImage = await imagePicker.pickImage(source: source);
      return pickedImage!.path;
    } catch (e) {
      return null;
    }
  }
}
