
import 'package:get/get.dart';

import '../../../utils/imports/app_imports.dart';
void showEmailVerificationDialog(String email) {
  showCustomDialog(
    title: MyText.verifyEmailTitle,
    content: "$email ${MyText.verifyEmailContent}",
    actions: [
      CustomElevatedButton(
        text: "ok",
        onPressed: () {
          Get.offAllNamed(AppRoutes.login);
        },
        height: 35.h,
        width: 70.w,
        borderRadius: 50,
        fontSize: Responsive.fontSize(Get.context!, 12.sp),
        backgroundColor: AppColors.secondaryButton,
      ),
    ],
  );
}
