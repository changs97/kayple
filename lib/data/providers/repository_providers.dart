import 'package:basic_project/base/network/log_interceptor.dart';
import 'package:basic_project/core/config.dart';
import 'package:basic_project/data/db/app_database.dart';
import 'package:basic_project/data/db/daos/post_dao.dart';
import 'package:basic_project/data/network/api_client.dart';
import 'package:basic_project/data/repositories/post_repository_impl.dart';
import 'package:basic_project/domain/repository/post_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.interceptors.add(NetworkLogInterceptor());
  return dio;
});

final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  final config = ref.watch(configProvider);
  return ApiClient(dio, baseUrl: config.baseUrl);
});

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final postDaoProvider = Provider<PostDao>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return PostDao(database);
});

final postRepositoryProvider = Provider<PostRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final postDao = ref.watch(postDaoProvider);
  return PostRepositoryImpl(apiClient: apiClient, postDao: postDao);
});
