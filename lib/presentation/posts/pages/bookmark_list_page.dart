import 'package:basic_project/presentation/common/error_widget.dart';
import 'package:basic_project/presentation/posts/pages/post_item_adapter.dart';
import 'package:basic_project/presentation/posts/viewmodels/bookmark_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookmarkListPage extends GetView<BookmarkListViewModel> {
  const BookmarkListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('즐겨찾기'),
      ),
      body: Obx(() {
        if (controller.state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.state.error != null) {
          return ErrorRetryWidget(
            error: controller.state.error,
            onRetry: () => controller.loadBookmarkedPosts(),
          );
        }

        if (controller.state.posts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bookmark_border,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  '즐겨찾기한 게시물이 없습니다',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.state.posts.length,
          itemBuilder: (context, index) {
            final post = controller.state.posts[index];
            return PostItemAdapter(
              key: ValueKey('bookmark_${post.id}'),
              post: post,
              onTap: () {
                Get.toNamed('/post/${post.id}');
              },
              onBookmarkTap: () {
                controller.toggleBookmark(post.id, post.isBookmarked);
              },
            );
          },
        );
      }),
    );
  }
}

