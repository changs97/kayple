import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BookmarkStorage {
  static const String _bookmarkKey = 'bookmarked_post_ids';
  final GetStorage _storage;
  Set<int>? _cachedIds;
  
  // 변경 알림을 위한 Rx 변수
  final _bookmarkChanged = 0.obs;
  int get bookmarkChangeCount => _bookmarkChanged.value;
  RxInt get bookmarkChangeCountRx => _bookmarkChanged;

  BookmarkStorage(this._storage);

  /// 즐겨찾기된 게시물 ID 목록 가져오기
  List<int> getBookmarkedIds() {
    final List<dynamic>? ids = _storage.read(_bookmarkKey);
    if (ids == null) return [];
    return ids.cast<int>();
  }

  /// 즐겨찾기된 게시물 ID Set 가져오기 (캐싱)
  Set<int> _getBookmarkedIdsSet() {
    _cachedIds ??= getBookmarkedIds().toSet();
    return _cachedIds!;
  }

  /// 캐시 무효화
  void _invalidateCache() {
    _cachedIds = null;
  }

  /// 게시물이 즐겨찾기되어 있는지 확인
  bool isBookmarked(int postId) {
    return _getBookmarkedIdsSet().contains(postId);
  }

  /// 즐겨찾기 추가
  Future<void> addBookmark(int postId) async {
    final bookmarkedIds = getBookmarkedIds();
    if (!bookmarkedIds.contains(postId)) {
      bookmarkedIds.add(postId);
      await _storage.write(_bookmarkKey, bookmarkedIds);
      _invalidateCache();
      _notifyChange();
    }
  }

  /// 즐겨찾기 제거
  Future<void> removeBookmark(int postId) async {
    final bookmarkedIds = getBookmarkedIds();
    if (bookmarkedIds.remove(postId)) {
      await _storage.write(_bookmarkKey, bookmarkedIds);
      _invalidateCache();
      _notifyChange();
    }
  }

  /// 변경 알림
  void _notifyChange() {
    _bookmarkChanged.value++;
  }

  /// 즐겨찾기 토글
  Future<bool> toggleBookmark(int postId) async {
    if (isBookmarked(postId)) {
      await removeBookmark(postId);
      return false;
    } else {
      await addBookmark(postId);
      return true;
    }
  }

  /// 모든 즐겨찾기 제거
  Future<void> clearAll() async {
    await _storage.remove(_bookmarkKey);
    _invalidateCache();
    _notifyChange();
  }
}

