import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class NewPostProvider extends ChangeNotifier {
  List<XFile> selectedImages = [];
  final int maxPostImages = 4;

  Future<void> pickImageFromGallery() async {
    final List<XFile> selection = await ImagePicker().pickMultiImage();

    if (selectedImages.length < maxPostImages) {
      selectedImages.addAll(selection);
      notifyListeners();
    }
  }

  void processPost() {
    //TODO : Fonction de publication
  }
}
