import 'package:get/get.dart';
import 'package:xpk/utils/imports/app_imports.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final AuthController controller = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RxBool isPasswordVisible = false.obs;
  RxBool isRememberMe = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColors.scafoldBackGroundGrandient,
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double screenWidth = constraints.maxWidth;
            double screenHeight = constraints.maxHeight;

            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 70, bottom: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'logo',
                        child: Image.asset(
                          AppImages.logo1,
                          height: screenHeight * 0.13,
                          width: screenWidth * 0.5,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.045,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextWidget(
                          text: MyText.login,
                          fWeight: MyFontWeight.samiBold,
                          textColor: AppColors.primaryAppBar,
                          fSize: 30,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      CustomTextField(
                        hintText: MyText.email,
                        backgroundColor: Colors.transparent,
                        borderColor: Colors.white,
                        borderRadius: 50,
                        validator: controller.validateEmail,
                        onChanged: (value) => controller.userName.value = value,
                      ),
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      Obx(() {
                        return CustomTextField(
                          hintText: MyText.password,
                          isPassword: !isPasswordVisible.value,
                          backgroundColor: Colors.transparent,
                          borderColor: Colors.white,
                          borderRadius: 50,
                          validator: controller.validatePassword,
                          trailingIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              isPasswordVisible.value =
                                  !isPasswordVisible.value;
                            },
                          ),
                          onChanged: (value) =>
                              controller.newPassword.value = value,
                        );
                      }),
                      Row(
                        children: [
                          // Obx(() {
                          //   return Checkbox(
                          //     value: isRememberMe.value,
                          //     onChanged: (value) {
                          //       isRememberMe.value = value!;
                          //     },
                          //     activeColor: AppColors.primaryButton,
                          //     splashRadius: 30,
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(7),
                          //     ),
                          //   );
                          // }),
                          // InkWell(
                          //   //onTap: ,
                          //   child: TextWidget(
                          //     text: MyText.termAndCondition,
                          //     fSize: 16,
                          //     textColor: AppColors.warning,
                          //   ),
                          // ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.forgetPasswordScreen);
                            },
                            child: TextWidget(
                              text: MyText.forgotPassword,
                              fSize: Responsive.fontSize(context, 14),
                              textColor: AppColors.primaryButton,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: CustomElevatedButton(
                          borderRadius: 50,
                          text: MyText.login,
                          fontSize: Responsive.fontSize(context, 18),
                          gradient: AppColors.buttonGradian,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              controller.login();
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.045,
                      ),
                      Row(
                        children: [
                          TextWidget(
                            text: MyText.dontHaveAccount,
                            fSize: Responsive.fontSize(context, 16),
                            textColor: AppColors.whiteBar,
                          ),
                          Hero(
                            tag: 'signup',
                            child: TextButton(
                              onPressed: () {
                                Get.toNamed(AppRoutes.signup);
                              },
                              child: TextWidget(
                                text: MyText.signUp,
                                fWeight: MyFontWeight.bold,
                                fSize: Responsive.fontSize(context, 16),
                                textColor: AppColors.primaryButton,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
