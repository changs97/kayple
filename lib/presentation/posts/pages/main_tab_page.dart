import 'package:basic_project/presentation/posts/pages/bookmark_list_page.dart';
import 'package:basic_project/presentation/posts/pages/post_list_page.dart';
import 'package:flutter/material.dart';

class MainTabPage extends StatelessWidget {
  const MainTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('KAYPLE'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list), text: '전체'),
              Tab(icon: Icon(Icons.bookmark), text: '즐겨찾기'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PostListPage(),
            BookmarkListPage(),
          ],
        ),
      ),
    );
  }
}

