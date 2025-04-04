import 'package:get/get.dart';
import 'package:xpk/app_module/new_blog_screen/controller/new_blog_controller.dart';
import 'package:xpk/utils/imports/app_imports.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    debugPrint('========================= AuthBinding');
    Get.put<AuthController>(AuthController());
    Get.put<HomeController>(HomeController());
    Get.put<DetailPlaceController>(DetailPlaceController());
    Get.put<NewBlogController>(NewBlogController());

  }
}
