import 'package:drift/drift.dart';

class Posts extends Table {
  IntColumn get id => integer()();

  IntColumn get userId => integer()();

  TextColumn get title => text()();

  TextColumn get body => text()();

  BoolColumn get isBookmarked => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
