import 'package:get/get.dart';
import 'package:xpk/utils/imports/app_imports.dart';

// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthController controller = Get.find<AuthController>();
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
                      left: 20, right: 20, top: 40, bottom: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Hero(
                            tag: 'signUp',
                            child: TextWidget(
                              text: MyText.signUp,
                              fSize: 30,
                              fWeight: FontWeights.bold,
                              textColor: AppColors.primaryAppBar,
                            ),
                          ),
                          Obx(() {
                            return Stack(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: AppColors.gray100,
                                  backgroundImage: controller.image.value !=
                                          null
                                      ? FileImage(controller.image
                                          .value!) // Use `.value!` to get the File
                                      : AssetImage(AppImages.defultProfile)
                                          as ImageProvider,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      controller.pickImage();
                                    },
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Colors.blue,
                                      child: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                      10.sbh,
                      CustomTextField(
                        hintText: MyText.userName,
                        backgroundColor: Colors.transparent,
                        borderColor: Colors.white,
                        borderRadius: 50,
                        validator: controller.validUserName,
                        textInputAction: TextInputAction.next,
                        trailingIcon: Icon(Icons.person, color: Colors.white),
                        onChanged: (value) => controller.userName.value = value,
                      ),
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      CustomTextField(
                        hintText: MyText.emailSignUp,
                        backgroundColor: Colors.transparent,
                        borderColor: Colors.white,
                        borderRadius: 50,
                        validator: controller.validateEmail,
                        textInputAction: TextInputAction.next,
                        trailingIcon: Icon(Icons.email, color: Colors.white),
                        onChanged: (value) => controller.email.value = value,
                      ),
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      Obx(() {
                        return CustomTextField(
                          hintText: MyText.passwordSignUp,
                          isPassword: !controller.isPasswordVisible.value,
                          backgroundColor: Colors.transparent,
                          borderColor: Colors.white,
                          borderRadius: 50,
                          validator: controller.validatePassword,
                          trailingIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              controller.isPasswordVisible.value =
                                  !controller.isPasswordVisible.value;
                            },
                          ),
                          onChanged: (value) =>
                              controller.newPassword.value = value,
                        );
                      }),
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      Obx(() {
                        return CustomTextField(
                          hintText: MyText.confirmPassword,
                          isPassword: controller.isPasswordConfirmVisible.value,
                          backgroundColor: Colors.transparent,
                          borderColor: Colors.white,
                          borderRadius: 50,
                          validator: (value) =>
                              controller.validateConfirmPassword(
                                  value, controller.newPassword.value),
                          trailingIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordConfirmVisible.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              controller.isPasswordConfirmVisible.value =
                                  !controller.isPasswordConfirmVisible.value;
                            },
                          ),
                        );
                      }),
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextWidget(
                          text: "Gender",
                          fSize: Responsive.fontSize(context, 20),
                          textColor: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          controller.genderContainer('Male'),
                          controller.genderContainer('Female'),
                          controller.genderContainer('Other'),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      Row(
                        children: [
                          Obx(() {
                            return CustomContainer(
                              width: screenWidth * 0.5,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextWidget(
                                    text: controller.birthday.value,
                                    fSize: Responsive.fontSize(context, 16),
                                    textColor: Colors.white,
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.010,
                                  ),
                                  Icon(Icons.calendar_today_sharp,
                                      color: Colors.white),
                                ],
                              ),
                              onTap: () {
                                controller.selectBirthday(context);
                              },
                              borderRadius: BorderRadius.circular(50),
                              borderColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            );
                          }),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      Obx(() {
                        return controller.check.value
                            ? customLoader(AppColors.primaryAppBar)
                            : Material(
                                color: Colors.transparent,
                                child: CustomElevatedButton(
                                  borderRadius: 50,
                                  text: MyText.signUp,
                                  fontSize: Responsive.fontSize(context, 18),
                                  gradient: AppColors.buttonGradian,
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate() &&
                                        controller.birthday.value.isNotEmpty &&
                                        controller.image.value != null) {
                                      await controller.signup();
                                      showCustomDialog(
                                        title: MyText.verifyEmailTitle,
                                        content: controller.email.value +
                                            " " +
                                            MyText.verifyEmailContent,
                                        actions: [
                                          CustomElevatedButton(
                                            text: "ok",
                                            onPressed: () {
                                              Get.offAllNamed(AppRoutes.login);
                                            },
                                            height: 35.h,
                                            width: 70.w,
                                            borderRadius: 50,
                                            fontSize: Responsive.fontSize(
                                                context, 12.sp),
                                            // gradient: AppColors.buttonGradian,
                                            backgroundColor:
                                                AppColors.secondaryButton,
                                          ),
                                        ],
                                      );
                                      // Get.toNamed(AppRoutes.login);
                                    } else {
                                      showCustomSnackBar(
                                        title: 'Failed',
                                        message:
                                            'Select image profile & Birthday',
                                        backgroundColor:
                                            AppColors.primaryButton,
                                        textColor: Colors.white,
                                        icon: Icons.error,
                                      );
                                    }
                                    // Get.toNamed(Routes.signup);
                                  },
                                ),
                              );
                      }),
                      SizedBox(
                        height: screenHeight * 0.045,
                      ),
                      Row(
                        children: [
                          TextWidget(
                            text: MyText.alreadyAccount,
                            fSize: Responsive.fontSize(context, 16),
                            textColor: AppColors.whiteBar,
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.login);
                            },
                            child: TextWidget(
                              text: MyText.login,
                              fWeight: FontWeights.bold,
                              fSize: Responsive.fontSize(context, 16),
                              textColor: AppColors.primaryButton,
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
