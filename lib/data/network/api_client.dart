import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'dto/post_dto.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/posts')
  Future<List<PostDto>> getPosts();

  @GET('/posts/{id}')
  Future<PostDto> getPostDetail(@Path('id') int id);
}
