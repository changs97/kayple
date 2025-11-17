import 'package:basic_project/data/providers/repository_providers.dart';
import 'package:basic_project/domain/entities/post.dart';
import 'package:basic_project/domain/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postDetailViewModelProvider =
    StateNotifierProvider.family<PostDetailViewModel, PostDetailState, int>((
      ref,
      postId,
    ) {
      final repository = ref.watch(postRepositoryProvider);
      return PostDetailViewModel(repository, postId);
    });

class PostDetailState {
  final Post? post;
  final bool isLoading;
  final Object? error;

  PostDetailState({this.post, this.isLoading = false, this.error});

  PostDetailState copyWith({Post? post, bool? isLoading, Object? error}) {
    return PostDetailState(
      post: post ?? this.post,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class PostDetailViewModel extends StateNotifier<PostDetailState> {
  final PostRepository repository;
  final int postId;

  PostDetailViewModel(this.repository, this.postId) : super(PostDetailState()) {
    loadPostDetail();
  }

  Future<void> loadPostDetail() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await repository.getPostDetail(postId);
    result.when(
      success: (post) {
        state = state.copyWith(post: post, isLoading: false, error: null);
      },
      failure: (error, stackTrace) {
        state = state.copyWith(isLoading: false, error: error);
      },
    );
  }

  Future<void> toggleBookmark() async {
    final currentPost = state.post;
    if (currentPost == null) return;

    final result = await repository.toggleBookmark(
      currentPost.id,
      currentPost.isBookmarked,
    );
    result.when(
      success: (_) {
        state = state.copyWith(
          post: currentPost.copyWith(isBookmarked: !currentPost.isBookmarked),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(error: error);
      },
    );
  }
}
