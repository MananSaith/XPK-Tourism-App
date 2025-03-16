import 'package:get/get.dart';
import 'package:xpk/utils/imports/app_imports.dart';

// ignore: must_be_immutable
class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: AppColors.scafoldBackGroundGrandient,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      10.sbh,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: AppColors.jetBlack,
                            )),
                      ),
                      20.sbh,
                      Image.asset(
                        AppImages.logo,
                        width: screenWidth * 0.5,
                      ),
                      20.sbh,
                      Text(
                        MyText.resetPassword,
                        style: TextStyle(
                          color: AppColors.jetBlack,
                          fontSize: screenWidth * 0.06,
                          fontWeight: MyFontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      CustomTextField(
                        hintText: MyText.email,
                        backgroundColor: Colors.transparent,
                        borderColor: Colors.white,
                        borderRadius: 50,
                        validator: controller.validateEmail,
                        onChanged: (value) => controller.email.value = value,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Material(
                        color: Colors.transparent,
                        child: CustomElevatedButton(
                          borderRadius: 50,
                          text: MyText.forget,
                          fontSize: Responsive.fontSize(context, 18),
                          gradient: AppColors.buttonGradian,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              showCustomDialog(
                             
                             
                                title: MyText.resetPassword,
                                content: controller.email.value +
                                    " " +
                                    MyText.content_forget,
                                actions: [
                                  CustomElevatedButton(
                                    text: "ok",
                                    onPressed: () {
                                      Get.offAllNamed(AppRoutes.login);
                                    },
                                    height: 35.h,
                                    width: 70.w,
                                    borderRadius: 50,
                                    fontSize:
                                        Responsive.fontSize(context, 12.sp),
                                    // gradient: AppColors.buttonGradian,
                                    backgroundColor: AppColors.secondaryButton,
                                  ),
                                ],
                              );

                              // Get.toNamed(Routes.signup);
                            }
                            ;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
