import 'package:basic_project/presentation/common/error_widget.dart';
import 'package:basic_project/presentation/posts/viewmodels/post_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostDetailPage extends GetView<PostDetailViewModel> {
  const PostDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시물 상세'),
        actions: [
          Obx(() {
            final state = controller.state;
            final post = state.post;
            if (post == null || state.isLoading) {
              return const SizedBox.shrink();
            }
            return IconButton(
              icon: Icon(
                post.isBookmarked
                    ? Icons.bookmark
                    : Icons.bookmark_border,
                color: post.isBookmarked ? Colors.amber : null,
              ),
              onPressed: () {
                controller.toggleBookmark();
              },
            );
          }),
        ],
      ),
      body: Obx(() {
        final state = controller.state;
        
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (state.error != null) {
          return ErrorRetryWidget(
            error: state.error,
            onRetry: () => controller.loadPostDetail(),
          );
        }
        
        final post = state.post;
        if (post == null) {
          return const Center(child: Text('게시물을 찾을 수 없습니다'));
        }
        
        return SingleChildScrollView(
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
        );
      }),
    );
  }
}
