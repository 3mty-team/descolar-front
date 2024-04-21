import '../../features/post/data/models/post_model.dart';

class CachedPost {
  static List<PostModel> feed = [];

  static bool postAlreadyInFeed(PostModel post) {
    for (var element in feed) {
      if (post.postId == element.postId) {
        return true;
      }
    }
    return false;
  }
}
