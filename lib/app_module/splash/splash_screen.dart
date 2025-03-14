

import 'package:get/get.dart';
import 'package:xpk/utils/imports/app_imports.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    RxDouble opacity = 0.0.obs;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(AppRoutes.getStart);
    });
    Future.delayed(const Duration(seconds: 1), () {
      opacity.value = 1.0;
    });

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Center(
        child: Obx(() => AnimatedOpacity(
              duration: const Duration(seconds: 2),
              opacity: opacity.value,
              child: SizedBox(
                height: height * 0.2,
                width: width * 0.4,
                child: Image.asset(AppImages.icon),
              ),
            )),
      ),
    );
  }
}
