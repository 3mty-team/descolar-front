import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:descolar_front/core/components/snack_bars.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/post/business/usecases/create_post.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/post/business/repositories/post_repository.dart';

class NewPostProvider extends ChangeNotifier {
  List<XFile> selectedImages = [];
  final int maxPostImages = 4;
  TextEditingController controller = TextEditingController();

  Future<void> pickImageFromGallery() async {
    final List<XFile> selection = await ImagePicker().pickMultiImage();

    if (selectedImages.length < maxPostImages) {
      selectedImages.addAll(selection);
      notifyListeners();
    }
  }

  void processPost(BuildContext context) async {
    PostRepository repository = await PostRepository.getPostRepository();
    final failureOrPost = await CreatePost(postRepository: repository).call(
      params: CreatePostParams(
        content: controller.text,
        location: await Ipify.ipv4(),
        postDate: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        media: selectedImages.isNotEmpty ? selectedImages : null,
      ),
    );
    failureOrPost.fold(
      (Failure failure) {
        notifyListeners();
      },
      (PostEntity post) {
        Navigator.pushReplacementNamed(context, '/home');
        controller.clear();
        SnackBars.successSnackBar(context: context, title: 'Votre post a bien été publié !');
        notifyListeners();
      },
    );
  }
}
