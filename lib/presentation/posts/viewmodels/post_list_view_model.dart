import 'package:basic_project/data/storage/bookmark_storage.dart';
import 'package:basic_project/domain/entities/post.dart';
import 'package:basic_project/domain/repository/post_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';

part 'post_list_view_model.freezed.dart';

@freezed
class PostListState with _$PostListState {
  const factory PostListState({
    @Default([]) List<Post> posts,
    @Default(false) bool isLoading,
    Object? error,
  }) = _PostListState;

  factory PostListState.loading() => const PostListState(isLoading: true);
  factory PostListState.success(List<Post> posts) => PostListState(posts: posts);
  factory PostListState.error(Object err) => PostListState(error: err);
}

class PostListViewModel extends GetxController {
  PostRepository? _repository;
  BookmarkStorage? _bookmarkStorage;

  PostRepository get repository {
    _repository ??= Get.find<PostRepository>();
    return _repository!;
  }

  BookmarkStorage get bookmarkStorage {
    _bookmarkStorage ??= Get.find<BookmarkStorage>();
    return _bookmarkStorage!;
  }

  final _state = PostListState().obs;

  PostListState get state => _state.value;

  @override
  void onInit() {
    super.onInit();
    loadPosts();
    
    // BookmarkStorage 변경 감지하여 북마크 상태 동기화
    ever(bookmarkStorage.bookmarkChangeCountRx, (_) {
      if (!isClosed && _state.value.posts.isNotEmpty) {
        _syncBookmarkStatus();
      }
    });
  }

  @override
  void onClose() {
    _repository = null;
    _bookmarkStorage = null;
    super.onClose();
  }

  /// BookmarkStorage의 실제 상태와 동기화
  void _syncBookmarkStatus() {
    final bookmarkedIds = bookmarkStorage.getBookmarkedIds().toSet();
    final updatedPosts = _state.value.posts.map((post) {
      return post.copyWith(isBookmarked: bookmarkedIds.contains(post.id));
    }).toList();
    _state.value = _state.value.copyWith(posts: updatedPosts);
  }

  Future<void> loadPosts() async {
    if (isClosed) return;
    _state.value = PostListState.loading();
    
    final result = await repository.getPosts();
    if (isClosed) return;
    
    result.when(
      success: (posts) {
        if (!isClosed) {
          _state.value = PostListState.success(posts);
        }
      },
      failure: (error, stackTrace) {
        if (!isClosed) {
          _state.value = PostListState.error(error);
        }
      },
    );
  }

  Future<void> toggleBookmark(int postId, bool isBookmarked) async {
    if (isClosed) return;
    
    // 낙관적 업데이트 (Optimistic Update)
    final currentPosts = _state.value.posts;
    final postIndex = currentPosts.indexWhere((post) => post.id == postId);
    if (postIndex == -1) return;

    final updatedPost = currentPosts[postIndex].copyWith(isBookmarked: !isBookmarked);
    final updatedPosts = List<Post>.from(currentPosts);
    updatedPosts[postIndex] = updatedPost;
    
    if (!isClosed) {
      _state.value = _state.value.copyWith(posts: updatedPosts);
    }

    final result = await repository.toggleBookmark(postId, !isBookmarked);
    if (isClosed) return;
    
    result.when(
      success: (_) {
        // BookmarkStorage 변경 감지로 자동 동기화됨
      },
      failure: (error, stackTrace) {
        if (!isClosed) {
          // 실패 시 롤백
          _state.value = _state.value.copyWith(posts: currentPosts);
          _state.value = PostListState.error(error);
        }
      },
    );
  }
}
