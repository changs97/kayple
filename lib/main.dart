import 'package:basic_project/base/navigation/app_routes.dart';
import 'package:basic_project/base/theme/theme.dart';
import 'package:basic_project/data/providers/repository_providers.dart';
import 'package:basic_project/presentation/posts/bindings/post_detail_binding.dart';
import 'package:basic_project/presentation/posts/pages/main_tab_page.dart';
import 'package:basic_project/presentation/posts/pages/post_detail_page.dart';
import 'package:basic_project/presentation/posts/viewmodels/bookmark_list_view_model.dart';
import 'package:basic_project/presentation/posts/viewmodels/post_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  await DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'KAYPLE',
      theme: BaseTheme.light(),
      initialRoute: AppRoutes.home,
      getPages: [
        GetPage(
          name: AppRoutes.home,
          page: () => const MainTabPage(),
          bindings: [
            BindingsBuilder(() {
              Get.lazyPut<PostListViewModel>(() => PostListViewModel());
            }),
            BindingsBuilder(() {
              Get.lazyPut<BookmarkListViewModel>(() => BookmarkListViewModel());
            }),
          ],
        ),
        GetPage(
          name: '/post/:id',
          page: () => const PostDetailPage(),
          binding: PostDetailBinding(),
        ),
      ],
    );
  }
}
