import 'package:basic_project/base/navigation/app_routes.dart';
import 'package:basic_project/presentation/common/error_widget.dart';
import 'package:basic_project/presentation/posts/pages/post_item_adapter.dart';
import 'package:basic_project/presentation/posts/viewmodels/post_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostListPage extends GetView<PostListViewModel> {
  const PostListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('게시물 목록')),
      body: Obx(() {
        final state = controller.state;
        
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (state.error != null) {
          return ErrorRetryWidget(
            error: state.error,
            onRetry: () => controller.loadPosts(),
          );
        }
        
        if (state.posts.isEmpty) {
          return const Center(child: Text('게시물이 없습니다'));
        }
        
        return ListView.builder(
          itemCount: state.posts.length,
          itemBuilder: (context, index) {
            final post = state.posts[index];
            return PostItemAdapter(
              key: ValueKey('post_${post.id}'),
              post: post,
              onTap: () {
                Get.toNamed(AppRoutes.postDetail(post.id));
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
