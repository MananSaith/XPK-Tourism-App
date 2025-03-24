import 'package:get/get.dart';
import 'package:xpk/utils/imports/app_imports.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    debugPrint('========================= AuthBinding');
    Get.put<AuthController>(AuthController());
    Get.put<HomeController>(HomeController());

  }
}
