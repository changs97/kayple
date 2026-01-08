import 'package:basic_project/base/network/log_interceptor.dart';
import 'package:basic_project/core/config.dart';
import 'package:basic_project/data/network/api_client.dart';
import 'package:basic_project/data/repositories/post_repository_impl.dart';
import 'package:basic_project/data/storage/bookmark_storage.dart';
import 'package:basic_project/domain/repository/post_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DependencyInjection {
  static Future<void> init() async {
    // GetStorage 초기화
    await GetStorage.init();
    final getStorage = GetStorage();
    Get.put<GetStorage>(getStorage, permanent: true);

    // BookmarkStorage
    Get.put<BookmarkStorage>(
      BookmarkStorage(getStorage),
      permanent: true,
    );

    // Dio
    Get.put<Dio>(
      Dio(BaseOptions(
        headers: {
          'User-Agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1',
          'Accept': 'application/json',
          'Accept-Language': 'en-US,en;q=0.9',
          'Referer': 'https://jsonplaceholder.typicode.com/',
        },
      ))..interceptors.add(NetworkLogInterceptor()),
      permanent: true,
    );

    // ApiClient
    Get.put<ApiClient>(
      ApiClient(Get.find<Dio>(), baseUrl: ConfigService.instance.baseUrl),
      permanent: true,
    );

    // PostRepository
    Get.put<PostRepository>(
      PostRepositoryImpl(
        apiClient: Get.find<ApiClient>(),
        bookmarkStorage: Get.find<BookmarkStorage>(),
      ),
      permanent: true,
    );
  }
}
