import 'package:dart_ipify/dart_ipify.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/post/business/usecases/create_post.dart';
import 'package:descolar_front/features/post/data/datasources/post_local_data_source.dart';
import 'package:descolar_front/features/post/data/datasources/post_remote_data_source.dart';
import 'package:descolar_front/features/post/data/repositories/post_repository_impl.dart';
import 'package:descolar_front/core/connection/network_info.dart';
import 'package:descolar_front/core/errors/failure.dart';

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
    PostRepositoryImpl repository = PostRepositoryImpl(
      remoteDataSource: PostRemoteDataSourceImpl(dio: Dio()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localDataSource: PostLocalDataSourceImpl(sharedPreferences: await SharedPreferences.getInstance()),
    );

    final failureOrPost = await CreatePost(postRepository: repository).call(
      params: CreatePostParams(
        content: controller.text,
        location: await Ipify.ipv4(),
        postDate: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      ),
    );

    failureOrPost.fold(
      (Failure failure) {
        notifyListeners();
      },
      (PostEntity post) {
        Navigator.pushReplacementNamed(context, '/home');
        controller.clear();
        notifyListeners();
      },
    );
  }
}
