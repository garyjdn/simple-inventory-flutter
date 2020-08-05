
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageSelector {
  Future<PickedFile> selectImage() async {
    final picker = ImagePicker();

    return await picker.getImage(source: ImageSource.gallery);
  }

}