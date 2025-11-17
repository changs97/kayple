import 'package:basic_project/base/navigation/app_routes.dart';
import 'package:basic_project/base/theme/theme.dart';
import 'package:basic_project/presentation/posts/pages/post_detail_page.dart';
import 'package:basic_project/presentation/posts/pages/post_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KAYPLE',
      theme: BaseTheme.light(),
      initialRoute: AppRoutes.home,
      routes: {AppRoutes.home: (context) => const PostListPage()},
      onGenerateRoute: (settings) {
        if (settings.name?.startsWith('/post/') == true) {
          final id = int.tryParse(settings.name!.split('/').last);
          if (id != null) {
            return MaterialPageRoute(
              builder: (context) => PostDetailPage(postId: id),
              settings: settings,
            );
          }
        }
        return null;
      },
    );
  }
}
