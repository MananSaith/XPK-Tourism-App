import 'package:get/get.dart';
import 'package:xpk/utils/imports/app_imports.dart';

dividerLine() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: Get.width * 0.3,
        child: const Divider(
          height: 5,
        ),
      ),
      Padding(
        padding: AppPaddings.horizontal10,
        child: AppText(
          text: "or".tr,
        ),
      ),
      SizedBox(
        width: Get.width * 0.3,
        child: const Divider(
          height: 5,
        ),
      ),
    ],
  );
}
