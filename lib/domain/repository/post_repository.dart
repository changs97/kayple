import '../../core/result.dart';
import '../entities/post.dart';

abstract class PostRepository {
  Future<Result<List<Post>>> getPosts();
  Future<Result<Post>> getPostDetail(int id);
  Future<Result<void>> toggleBookmark(int id, bool isBookmarked);
}
