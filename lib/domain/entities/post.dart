class Post {
  final int userId;
  final int id;
  final String title;
  final String body;
  final bool isBookmarked;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
    this.isBookmarked = false,
  });

  Post copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
    bool? isBookmarked,
  }) {
    return Post(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }
}
