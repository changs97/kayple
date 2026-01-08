import 'package:basic_project/presentation/posts/viewmodels/post_detail_view_model.dart';
import 'package:get/get.dart';

class PostDetailBinding extends Bindings {
  @override
  void dependencies() {
    final id = int.tryParse(Get.parameters['id'] ?? '');
    if (id != null) {
      Get.lazyPut<PostDetailViewModel>(
        () => PostDetailViewModel(id),
        fenix: false, // 라우트 이탈 시 삭제
      );
    }
  }
}

