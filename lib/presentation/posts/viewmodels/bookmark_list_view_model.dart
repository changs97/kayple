import 'package:basic_project/data/storage/bookmark_storage.dart';
import 'package:basic_project/domain/entities/post.dart';
import 'package:basic_project/domain/repository/post_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';

part 'bookmark_list_view_model.freezed.dart';

@freezed
class BookmarkListState with _$BookmarkListState {
  const factory BookmarkListState({
    @Default([]) List<Post> posts,
    @Default(false) bool isLoading,
    Object? error,
  }) = _BookmarkListState;

  factory BookmarkListState.loading() => const BookmarkListState(isLoading: true);
  factory BookmarkListState.success(List<Post> posts) => BookmarkListState(posts: posts);
  factory BookmarkListState.error(Object err) => BookmarkListState(error: err);
}

class BookmarkListViewModel extends GetxController {
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

  final _state = BookmarkListState().obs;

  BookmarkListState get state => _state.value;

  @override
  void onInit() {
    super.onInit();
    loadBookmarkedPosts();
    
    // BookmarkStorage 변경 감지하여 자동 갱신
    ever(bookmarkStorage.bookmarkChangeCountRx, (_) {
      if (!isClosed) {
        loadBookmarkedPosts();
      }
    });
  }

  @override
  void onClose() {
    _repository = null;
    _bookmarkStorage = null;
    super.onClose();
  }

  Future<void> loadBookmarkedPosts() async {
    if (isClosed) return;
    _state.value = BookmarkListState.loading();

    try {
      final bookmarkedIds = bookmarkStorage.getBookmarkedIds();
      if (bookmarkedIds.isEmpty) {
        if (!isClosed) {
          _state.value = BookmarkListState.success([]);
        }
        return;
      }

      final bookmarkedIdsSet = bookmarkedIds.toSet(); // O(1) 조회를 위해 Set 사용
      final allPostsResult = await repository.getPosts();
      if (isClosed) return;
      
      allPostsResult.when(
        success: (allPosts) {
          if (!isClosed) {
            final bookmarked = allPosts
                .where((post) => bookmarkedIdsSet.contains(post.id))
                .toList();
            _state.value = BookmarkListState.success(bookmarked);
          }
        },
        failure: (error, stackTrace) {
          if (!isClosed) {
            _state.value = BookmarkListState.error(error);
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        _state.value = BookmarkListState.error(e);
      }
    }
  }

  Future<void> toggleBookmark(int postId, bool isBookmarked) async {
    if (isClosed) return;
    
    final result = await repository.toggleBookmark(postId, !isBookmarked);
    if (isClosed) return;
    
    result.when(
      success: (_) {
        if (!isClosed) {
          // 목록에서 제거
          final updatedPosts = _state.value.posts
              .where((post) => post.id != postId)
              .toList();
          _state.value = _state.value.copyWith(posts: updatedPosts);
        }
      },
      failure: (error, stackTrace) {
        if (!isClosed) {
          _state.value = BookmarkListState.error(error);
        }
      },
    );
  }

}

