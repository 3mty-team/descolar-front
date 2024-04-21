import '../../features/post/data/models/post_model.dart';

class CachedPost {
  static List<PostModel> feed = [];
  static List<PostModel> userPostList = [];

  static bool postAlreadyInFeed(PostModel post) {
    for (var element in feed) {
      if (post.postId == element.postId) {
        return true;
      }
    }
    return false;
  }

  static bool postAlreadyInUserList(PostModel post) {
    for (var element in userPostList) {
      if (post.postId == element.postId) {
        return true;
      }
    }
    return false;
  }
}
