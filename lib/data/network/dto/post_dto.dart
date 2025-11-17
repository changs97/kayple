import 'package:basic_project/domain/entities/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_dto.g.dart';

@JsonSerializable()
class PostDto {
  final int userId;
  final int id;
  final String title;
  final String body;

  PostDto({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostDto.fromJson(Map<String, dynamic> json) =>
      _$PostDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PostDtoToJson(this);

  Post toEntity() {
    return Post(userId: userId, id: id, title: title, body: body);
  }
}
