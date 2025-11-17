import 'package:basic_project/base/navigation/app_routes.dart';
import 'package:basic_project/presentation/posts/pages/post_item_adapter.dart';
import 'package:basic_project/presentation/posts/viewmodels/post_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListPage extends ConsumerStatefulWidget {
  const PostListPage({super.key});

  @override
  ConsumerState<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends ConsumerState<PostListPage> {

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postListViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('게시물 목록')),
      body:
          state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : state.error != null
              ? Center(child: Text('에러 발생: ${state.error}'))
              : state.posts.isEmpty
              ? const Center(child: Text('게시물이 없습니다'))
              : ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return PostItemAdapter(
                    post: post,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.postDetail(post.id),
                      );
                    },
                  );
                },
              ),
    );
  }
}
