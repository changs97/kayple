import 'package:basic_project/data/providers/repository_providers.dart';
import 'package:basic_project/domain/entities/post.dart';
import 'package:basic_project/domain/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postListViewModelProvider =
    StateNotifierProvider<PostListViewModel, PostListState>((ref) {
      final repository = ref.watch(postRepositoryProvider);
      return PostListViewModel(repository);
    });

class PostListState {
  final List<Post> posts;
  final bool isLoading;
  final Object? error;

  PostListState({this.posts = const [], this.isLoading = false, this.error});

  PostListState copyWith({List<Post>? posts, bool? isLoading, Object? error}) {
    return PostListState(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class PostListViewModel extends StateNotifier<PostListState> {
  final PostRepository repository;

  PostListViewModel(this.repository) : super(PostListState()) {
    loadPosts();
  }

  Future<void> loadPosts() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await repository.getPosts();
    result.when(
      success: (posts) {
        state = state.copyWith(posts: posts, isLoading: false, error: null);
      },
      failure: (error, stackTrace) {
        state = state.copyWith(isLoading: false, error: error);
      },
    );
  }

  Future<void> toggleBookmark(int postId, bool isBookmarked) async {
    final result = await repository.toggleBookmark(postId, !isBookmarked);
    result.when(
      success: (_) {
        final updatedPosts =
            state.posts.map((post) {
              if (post.id == postId) {
                return post.copyWith(isBookmarked: !isBookmarked);
              }
              return post;
            }).toList();
        state = state.copyWith(posts: updatedPosts);
      },
      failure: (error, stackTrace) {
        state = state.copyWith(error: error);
      },
    );
  }
}
