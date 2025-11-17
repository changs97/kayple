import 'package:basic_project/base/logger.dart';
import 'package:basic_project/core/result.dart';
import 'package:basic_project/data/db/daos/post_dao.dart';
import 'package:basic_project/data/network/api_client.dart';
import 'package:basic_project/domain/entities/post.dart';
import 'package:basic_project/domain/repository/post_repository.dart';
import 'package:dio/dio.dart';

class PostRepositoryImpl implements PostRepository {
  final ApiClient apiClient;
  final PostDao postDao;
  final Logger _logger = Logger.withTag('PostRepository');

  PostRepositoryImpl({required this.apiClient, required this.postDao});

  @override
  Future<Result<List<Post>>> getPosts() async {
    try {
      _logger.d('Fetching posts from API');
      final dtos = await apiClient.getPosts();
      final posts = dtos.map((dto) => dto.toEntity()).toList();

      _logger.d('Loading bookmarked posts from database');
      final bookmarkedIds = await postDao.getBookmarkedPosts();
      final bookmarkedIdsSet = bookmarkedIds.map((p) => p.id).toSet();

      final postsWithBookmark =
          posts.map((post) {
            final isBookmarked = bookmarkedIdsSet.contains(post.id);
            return post.copyWith(isBookmarked: isBookmarked);
          }).toList();

      await postDao.insertAllPosts(postsWithBookmark);
      _logger.i('Successfully loaded ${postsWithBookmark.length} posts');

      return Success(postsWithBookmark);
    } on DioException catch (e, stackTrace) {
      _logger.w('Network error occurred, trying to load from local database', error: e, stackTrace: stackTrace);
      try {
        final localPosts = await postDao.getAllPosts();
        _logger.i('Loaded ${localPosts.length} posts from local database');
        return Success(localPosts);
      } catch (dbError) {
        _logger.e('Failed to load from local database', error: dbError, stackTrace: stackTrace);
        return Failure(e, stackTrace);
      }
    } catch (e, stackTrace) {
      _logger.e('Unexpected error occurred', error: e, stackTrace: stackTrace);
      return Failure(e, stackTrace);
    }
  }

  @override
  Future<Result<Post>> getPostDetail(int id) async {
    try {
      _logger.d('Fetching post detail for id: $id');
      final localPost = await postDao.getPostById(id);
      final isBookmarked = localPost?.isBookmarked ?? false;

      final dto = await apiClient.getPostDetail(id);
      final post = dto.toEntity().copyWith(isBookmarked: isBookmarked);
      _logger.i('Successfully loaded post detail: $id');

      return Success(post);
    } on DioException catch (e, stackTrace) {
      _logger.w('Network error occurred, trying to load from local database', error: e, stackTrace: stackTrace);
      try {
        final localPost = await postDao.getPostById(id);
        if (localPost != null) {
          _logger.i('Loaded post from local database: $id');
          return Success(localPost);
        }
        _logger.e('Post not found in local database: $id');
        return Failure(e, stackTrace);
      } catch (dbError) {
        _logger.e('Failed to load from local database', error: dbError, stackTrace: stackTrace);
        return Failure(e, stackTrace);
      }
    } catch (e, stackTrace) {
      _logger.e('Unexpected error occurred', error: e, stackTrace: stackTrace);
      return Failure(e, stackTrace);
    }
  }

  @override
  Future<Result<void>> toggleBookmark(int id, bool isBookmarked) async {
    try {
      _logger.d('Toggling bookmark for post: $id, isBookmarked: $isBookmarked');
      await postDao.toggleBookmark(id, isBookmarked);
      _logger.i('Successfully toggled bookmark for post: $id');
      return const Success(null);
    } catch (e, stackTrace) {
      _logger.e('Failed to toggle bookmark', error: e, stackTrace: stackTrace);
      return Failure(e, stackTrace);
    }
  }
}
