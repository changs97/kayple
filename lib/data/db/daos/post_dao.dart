import 'package:basic_project/data/db/app_database.dart';
import 'package:basic_project/data/db/models/post_item.dart';
import 'package:basic_project/data/db/tables/tables.dart';
import 'package:basic_project/domain/entities/post.dart' as domain;
import 'package:drift/drift.dart';

part 'post_dao.g.dart';

@DriftAccessor(tables: [Posts])
class PostDao extends DatabaseAccessor<AppDatabase> with _$PostDaoMixin {
  PostDao(super.db);

  Future<List<domain.Post>> getAllPosts() async {
    final query = select(posts);
    final result = await query.get();
    return result.map((row) {
      return PostItem(
        id: row.id,
        userId: row.userId,
        title: row.title,
        body: row.body,
        isBookmarked: row.isBookmarked,
      ).toEntity();
    }).toList();
  }

  Future<domain.Post?> getPostById(int id) async {
    final query = select(posts)..where((tbl) => tbl.id.equals(id));
    final result = await query.getSingleOrNull();
    if (result == null) return null;
    return PostItem(
      id: result.id,
      userId: result.userId,
      title: result.title,
      body: result.body,
      isBookmarked: result.isBookmarked,
    ).toEntity();
  }

  Future<void> insertAllPosts(List<domain.Post> postList) async {
    final companions =
        postList
            .map((post) => PostItem.fromEntity(post).toCompanion())
            .toList();
    await batch((batch) {
      batch.insertAll(posts, companions, mode: InsertMode.replace);
    });
  }

  Future<void> toggleBookmark(int id, bool isBookmarked) async {
    await (update(posts)..where(
      (tbl) => tbl.id.equals(id),
    )).write(PostsCompanion(isBookmarked: Value(isBookmarked)));
  }

  Future<List<domain.Post>> getBookmarkedPosts() async {
    final query = select(posts)..where((tbl) => tbl.isBookmarked.equals(true));
    final result = await query.get();
    return result.map((row) {
      return PostItem(
        id: row.id,
        userId: row.userId,
        title: row.title,
        body: row.body,
        isBookmarked: row.isBookmarked,
      ).toEntity();
    }).toList();
  }
}
