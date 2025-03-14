import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:xpk/utils/font_weight/font_weight.dart';
import 'package:xpk/utils/constant/string_constant.dart';
import 'package:xpk/utils/responsive/responsive.dart';
import 'package:xpk/widegts/app_text/textwidget.dart';

import '../../../utils/app_color/app_color.dart';
import '../../../widegts/app_button/custum_button.dart';

class OtpController extends GetxController {
  var otp = ''.obs; // RxString to store the OTP entered by the user

  void setOtp(String value) {
    otp.value = value;
  }

  void verifyOtp() {
    if (otp.value.length == 6) {
      // Replace with your OTP verification logic
      print("OTP Entered: ${otp.value}");
      Get.snackbar('Success', 'OTP Verified Successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } else {
      Get.snackbar('Error', 'Please enter a valid 6-digit OTP',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}

class SignupEmailOtp extends StatelessWidget {
  SignupEmailOtp({super.key});

  final OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColors.scafoldBackGroundGrandient,
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            //double screenWidth = constraints.maxWidth;
            double screenHeight = constraints.maxHeight;

            return Padding(
              padding: const EdgeInsets.only(top: 45, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppColors.whiteBar,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.025,
                  ),
                  TextWidget(
                    text: MyText.codeEnter,
                    fSize: Responsive.fontSize(context, 25),
                    fWeight: MyFontWeight.extra,
                  ),
                  SizedBox(
                    height: screenHeight * 0.025,
                  ),
                  TextWidget(
                    text: "${MyText.codeEmail} mrmanan143@gmail.com",
                    fSize: Responsive.fontSize(context, 16),
                    fWeight: MyFontWeight.regular,
                  ),
                  SizedBox(height: 20),
                  OtpTextField(
                    numberOfFields: 6,
                    fieldWidth: 40,
                    borderColor: Color(0xFF512DA8),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    focusedBorderColor: Colors.blue,
                    showFieldAsBox: true,
                    onSubmit: (String otp) {
                      controller.setOtp(otp);
                    },
                  ),
                  SizedBox(height: 20),
                  Material(
                    color: Colors.transparent,
                    child: CustomElevatedButton(
                      borderRadius: 50,
                      text: MyText.verifyOtp,
                      fontSize: Responsive.fontSize(context, 18),
                      gradient: AppColors.buttonGradian,
                      onPressed: () {
                         
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
