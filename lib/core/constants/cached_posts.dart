import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/post/data/models/comment_model.dart';
import 'package:descolar_front/features/post/data/models/post_model.dart';

class CachedPost {
  static List<PostModel> feed = [];
  static List<PostEntity> userPostList = [];
  static List<PostEntity> likedPost = [];
  static List<CommentModel> loadedComments = [];
  static List<String> reportCategories = [];
  static List<String> diplomas = [];
  static List<String> formations = [];

  static PostEntity? postAlreadyInFeed(PostEntity post) {
    for (var element in feed) {
      if (post.postId == element.postId) {
        return element;
      }
    }
    return null;
  }

  static bool postAlreadyInUserList(PostEntity post) {
    for (var element in userPostList) {
      if (post.postId == element.postId) {
        return true;
      }
    }
    return false;
  }

  static bool postAlreadyInLikedPost(PostEntity post) {
    for (var element in likedPost) {
      if (post.postId == element.postId) {
        return true;
      }
    }
    return false;
  }

  static bool categorieAlreadyCached(String categorie) {
    for (String element in reportCategories) {
      if (categorie == element) {
        return true;
      }
    }
    return false;
  }

  static bool diplomaAlreadyCached(String diploma) {
    for (String element in diplomas) {
      if (diploma == element) {
        return true;
      }
    }
    return false;
  }

  static bool formationAlreadyCached(String formation) {
    for (String element in formations) {
      if (formation == element) {
        return true;
      }
    }
    return false;
  }
}
