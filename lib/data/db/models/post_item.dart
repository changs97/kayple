import 'package:basic_project/data/db/app_database.dart';
import 'package:basic_project/domain/entities/post.dart' as domain;
import 'package:drift/drift.dart';

class PostItem {
  final int userId;
  final int id;
  final String title;
  final String body;
  final bool isBookmarked;

  PostItem({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
    this.isBookmarked = false,
  });

  factory PostItem.fromEntity(domain.Post post) {
    return PostItem(
      userId: post.userId,
      id: post.id,
      title: post.title,
      body: post.body,
      isBookmarked: post.isBookmarked,
    );
  }

  domain.Post toEntity() {
    return domain.Post(
      userId: userId,
      id: id,
      title: title,
      body: body,
      isBookmarked: isBookmarked,
    );
  }

  PostsCompanion toCompanion() {
    return PostsCompanion(
      id: Value(id),
      userId: Value(userId),
      title: Value(title),
      body: Value(body),
      isBookmarked: Value(isBookmarked),
    );
  }
}
