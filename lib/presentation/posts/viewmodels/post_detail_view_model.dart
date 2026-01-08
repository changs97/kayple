import 'package:basic_project/data/storage/bookmark_storage.dart';
import 'package:basic_project/domain/entities/post.dart';
import 'package:basic_project/domain/repository/post_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';

part 'post_detail_view_model.freezed.dart';

@freezed
class PostDetailState with _$PostDetailState {
  const factory PostDetailState({
    Post? post,
    @Default(false) bool isLoading,
    Object? error,
  }) = _PostDetailState;

  factory PostDetailState.loading() => const PostDetailState(isLoading: true);
  factory PostDetailState.success(Post post) => PostDetailState(post: post);
  factory PostDetailState.error(Object err) => PostDetailState(error: err);
}

class PostDetailViewModel extends GetxController {
  PostRepository? _repository;
  BookmarkStorage? _bookmarkStorage;
  final int postId;

  PostDetailViewModel(this.postId);

  PostRepository get repository {
    _repository ??= Get.find<PostRepository>();
    return _repository!;
  }

  BookmarkStorage get bookmarkStorage {
    _bookmarkStorage ??= Get.find<BookmarkStorage>();
    return _bookmarkStorage!;
  }

  final _state = PostDetailState().obs;

  PostDetailState get state => _state.value;

  @override
  void onInit() {
    super.onInit();
    loadPostDetail();
    
    // BookmarkStorage 변경 감지하여 북마크 상태 동기화
    ever(bookmarkStorage.bookmarkChangeCountRx, (_) {
      if (!isClosed && _state.value.post != null) {
        final isBookmarked = bookmarkStorage.isBookmarked(postId);
        _state.value = _state.value.copyWith(
          post: _state.value.post!.copyWith(isBookmarked: isBookmarked),
        );
      }
    });
  }

  @override
  void onClose() {
    _repository = null;
    _bookmarkStorage = null;
    super.onClose();
  }

  Future<void> loadPostDetail() async {
    if (isClosed) return;
    _state.value = PostDetailState.loading();
    
    final result = await repository.getPostDetail(postId);
    if (isClosed) return;
    
    result.when(
      success: (post) {
        if (!isClosed) {
          _state.value = PostDetailState.success(post);
        }
      },
      failure: (error, stackTrace) {
        if (!isClosed) {
          _state.value = PostDetailState.error(error);
        }
      },
    );
  }

  Future<void> toggleBookmark() async {
    if (isClosed) return;
    final currentPost = _state.value.post;
    if (currentPost == null) return;

    final newBookmarkState = !currentPost.isBookmarked;
    
    // 낙관적 업데이트
    if (!isClosed) {
      _state.value = _state.value.copyWith(
        post: currentPost.copyWith(isBookmarked: newBookmarkState),
      );
    }

    final result = await repository.toggleBookmark(
      currentPost.id,
      newBookmarkState,
    );
    if (isClosed) return;
    
    result.when(
      success: (_) {
        // BookmarkStorage 변경 감지로 자동 동기화됨
      },
      failure: (error, stackTrace) {
        if (!isClosed) {
          // 실패 시 롤백
          _state.value = _state.value.copyWith(
            post: currentPost.copyWith(isBookmarked: !newBookmarkState),
          );
          _state.value = PostDetailState.error(error);
        }
      },
    );
  }
}
