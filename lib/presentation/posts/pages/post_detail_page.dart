import 'package:basic_project/presentation/posts/viewmodels/post_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailPage extends ConsumerWidget {
  final int postId;

  const PostDetailPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postDetailViewModelProvider(postId));
    final post = state.post;

    return Scaffold(
      appBar: AppBar(
        title: const Text('게시물 상세'),
          actions: [
            if (post != null)
              IconButton(
                icon: Icon(
                  post.isBookmarked
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  color: post.isBookmarked ? Colors.amber : null,
                ),
                onPressed: () {
                  ref
                      .read(postDetailViewModelProvider(postId).notifier)
                      .toggleBookmark();
                },
              ),
          ],
        ),
      body:
          state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : state.error != null
              ? Center(child: Text('에러 발생: ${state.error}'))
              : post == null
              ? const Center(child: Text('게시물을 찾을 수 없습니다'))
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(child: Text('${post.id}')),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ID: ${post.id}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                '작성자 ID: ${post.userId}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      post.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      post.body,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
    );
  }
}
