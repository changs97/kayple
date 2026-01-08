import 'package:basic_project/base/logger.dart';
import 'package:basic_project/core/result.dart';
import 'package:basic_project/data/network/api_client.dart';
import 'package:basic_project/data/storage/bookmark_storage.dart';
import 'package:basic_project/domain/entities/post.dart';
import 'package:basic_project/domain/repository/post_repository.dart';
import 'package:dio/dio.dart';

class PostRepositoryImpl implements PostRepository {
  final ApiClient apiClient;
  final BookmarkStorage bookmarkStorage;
  final Logger _logger = Logger.withTag('PostRepository');

  PostRepositoryImpl({
    required this.apiClient,
    required this.bookmarkStorage,
  });

  @override
  Future<Result<List<Post>>> getPosts() async {
    try {
      _logger.d('Fetching posts from API');
      final dtos = await apiClient.getPosts();
      final posts = dtos.map((dto) => dto.toEntity()).toList();

      _logger.d('Loading bookmarked posts from storage');
      final bookmarkedIds = bookmarkStorage.getBookmarkedIds();
      final bookmarkedIdsSet = bookmarkedIds.toSet(); // Set으로 변환하여 O(1) 조회

      final postsWithBookmark = posts.map((post) {
        final isBookmarked = bookmarkedIdsSet.contains(post.id);
        return post.copyWith(isBookmarked: isBookmarked);
      }).toList();

      _logger.i('Successfully loaded ${postsWithBookmark.length} posts');

      return Success(postsWithBookmark);
    } on DioException catch (e, stackTrace) {
      _logger.e('Network error occurred', error: e, stackTrace: stackTrace);
      return Failure(e, stackTrace);
    } catch (e, stackTrace) {
      _logger.e('Unexpected error occurred', error: e, stackTrace: stackTrace);
      return Failure(e, stackTrace);
    }
  }

  @override
  Future<Result<Post>> getPostDetail(int id) async {
    try {
      _logger.d('Fetching post detail for id: $id');
      final isBookmarked = bookmarkStorage.isBookmarked(id);

      final dto = await apiClient.getPostDetail(id);
      final post = dto.toEntity().copyWith(isBookmarked: isBookmarked);
      _logger.i('Successfully loaded post detail: $id');

      return Success(post);
    } on DioException catch (e, stackTrace) {
      _logger.e('Network error occurred', error: e, stackTrace: stackTrace);
      return Failure(e, stackTrace);
    } catch (e, stackTrace) {
      _logger.e('Unexpected error occurred', error: e, stackTrace: stackTrace);
      return Failure(e, stackTrace);
    }
  }

  @override
  Future<Result<void>> toggleBookmark(int id, bool isBookmarked) async {
    try {
      _logger.d('Toggling bookmark for post: $id, isBookmarked: $isBookmarked');
      if (isBookmarked) {
        await bookmarkStorage.addBookmark(id);
      } else {
        await bookmarkStorage.removeBookmark(id);
      }
      _logger.i('Successfully toggled bookmark for post: $id');
      return const Success(null);
    } catch (e, stackTrace) {
      _logger.e('Failed to toggle bookmark', error: e, stackTrace: stackTrace);
      return Failure(e, stackTrace);
    }
  }
}
