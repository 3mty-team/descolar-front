import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:descolar_front/features/post/business/repositories/comment_repository.dart';
import 'package:descolar_front/features/post/business/repositories/post_repository.dart';
import 'package:descolar_front/core/components/snack_bars.dart';
import 'package:descolar_front/features/post/business/entities/comment_entity.dart';
import 'package:descolar_front/features/post/business/usecases/create_comment.dart';
import 'package:descolar_front/features/post/business/usecases/delete_comment.dart';
import 'package:descolar_front/features/post/business/usecases/get_all_comments_in_range.dart';
import 'package:descolar_front/features/post/business/usecases/get_all_report_categories.dart';
import 'package:descolar_front/features/post/business/usecases/report_post.dart';
import 'package:descolar_front/features/post/business/usecases/like_post.dart';
import 'package:descolar_front/features/post/business/usecases/repost_post.dart';
import 'package:descolar_front/features/post/business/usecases/unlike_post.dart';
import 'package:descolar_front/features/post/business/usecases/delete_post.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';

class ActionPostProvider extends ChangeNotifier {
  TextEditingController controller = TextEditingController();

  void deletePost(BuildContext context, PostEntity post) async {
    PostRepository repository = await PostRepository.getPostRepository();
    final failureOrPost = await DeletePost(postRepository: repository).call(post: post);
    failureOrPost.fold(
      (Failure failure) {
        SnackBars.failureSnackBar(context: context, title: 'Le post n\'a pas pu être supprimé.');
        notifyListeners();
      },
      (bool response) {
        Navigator.pushNamed(context, '/home');
        SnackBars.successSnackBar(context: context, title: 'Votre post a bien été supprimé !');
        notifyListeners();
      },
    );
  }

  void repostPost(BuildContext context, int postID) async {
    PostRepository repository = await PostRepository.getPostRepository();
    final failureOrPost = await RepostPost(postRepository: repository).call(
      params: CreatePostParams(
        content: controller.text,
        location: await Ipify.ipv4(),
        postDate: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      ),
      postID: postID,
    );
    failureOrPost.fold(
      (Failure failure) {
        SnackBars.failureSnackBar(context: context, title: 'Le post n\'a pas pu être reposté.');
        notifyListeners();
      },
      (PostEntity post) {
        Navigator.pushReplacementNamed(context, '/home');
        controller.clear();
        SnackBars.successSnackBar(context: context, title: 'Vous avez republié ce post !');
        notifyListeners();
      },
    );
  }

  Future<void> likePost(BuildContext context, PostEntity post) async {
    PostRepository repository = await PostRepository.getPostRepository();
    final failureOrPost = await LikePost(postRepository: repository).call(
      post: post,
    );
    failureOrPost.fold(
      (Failure failure) {
        SnackBars.failureSnackBar(context: context, title: 'Le post n\'a pas pu être aimé.');
        notifyListeners();
      },
      (PostEntity response) {
        notifyListeners();
      },
    );
  }

  Future<void> unlikePost(BuildContext context, PostEntity post) async {
    PostRepository repository = await PostRepository.getPostRepository();
    final failureOrPost = await UnlikePost(postRepository: repository).call(
      post: post,
    );
    failureOrPost.fold(
      (Failure failure) {
        SnackBars.failureSnackBar(context: context, title: 'Une erreur est survenue.');
        notifyListeners();
      },
      (PostEntity response) {
        notifyListeners();
      },
    );
  }

  Future<void> reportPost(BuildContext context, ReportPostParams params) async {
    PostRepository repository = await PostRepository.getPostRepository();
    final failureOrPost = await ReportPost(postRepository: repository).call(
      params: params,
    );
    failureOrPost.fold(
      (Failure failure) {
        SnackBars.failureSnackBar(context: context, title: 'Une erreur est survenue.');
        notifyListeners();
      },
      (bool response) {
        Navigator.pushNamed(context, '/home');
        controller.clear();
        SnackBars.successSnackBar(context: context, title: 'Merci pour votre signalement. L\'équipe de modération traitera celui-ci dans les meilleurs délais.');
        notifyListeners();
      },
    );
  }

  void createComment(BuildContext context, PostEntity post) async {
    CommentRepository repository = await CommentRepository.getCommentRepository();
    final failureOrPost = await CreateComment(commentRepository: repository).call(
      params: CreateCommentParams(
        post: post,
        content: controller.text,
        commentDate: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      ),
    );
    failureOrPost.fold(
      (Failure failure) {
        SnackBars.failureSnackBar(context: context, title: 'La réponse n\'a pas pu être publiée.');
        notifyListeners();
      },
      (CommentEntity comment) {
        Navigator.pushNamed(context, '/home');
        controller.clear();
        SnackBars.successSnackBar(context: context, title: 'Votre réponse a bien été publiée !');
        notifyListeners();
      },
    );
  }

  void deleteComment(BuildContext context, CommentEntity comment) async {
    CommentRepository repository = await CommentRepository.getCommentRepository();
    final failureOrPost = await DeleteComment(commentRepository: repository).call(
      comment: comment,
    );
    failureOrPost.fold(
      (Failure failure) {
        SnackBars.failureSnackBar(context: context, title: 'Le commentaire n\'a pas pu être supprimé.');
        notifyListeners();
      },
      (bool response) {
        Navigator.pushNamed(context, '/home');
        SnackBars.successSnackBar(context: context, title: 'Votre réponse a bien été supprimée !');
        notifyListeners();
      },
    );
  }

  Future<void> getAllCommentsInRange(BuildContext context, PostEntity post) async {
    CommentRepository repository = await CommentRepository.getCommentRepository();
    final failureOrPost = await GetAllCommentsInRange(commentRepository: repository).call(
      post: post,
      range: 20,
    );
    failureOrPost.fold(
      (Failure failure) {
        SnackBars.failureSnackBar(context: context, title: 'Une erreur est survenue lors de la récupération des réponses.');
        notifyListeners();
      },
      (List<CommentEntity> comments) {
        notifyListeners();
      },
    );
  }

  Future<void> getAllReportCategories(BuildContext context) async {
    PostRepository repository = await PostRepository.getPostRepository();
    final failureOrPost = await GetAllReportCategories(postRepository: repository).call();
    failureOrPost.fold(
      (Failure failure) {
        SnackBars.failureSnackBar(context: context, title: 'Une erreur est survenue.');
        notifyListeners();
      },
      (List<String> categories) {
        notifyListeners();
      },
    );
  }
}
