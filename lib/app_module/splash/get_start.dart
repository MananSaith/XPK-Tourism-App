

import 'package:get/get.dart';
import 'package:xpk/utils/imports/app_imports.dart';

class GetStart extends StatelessWidget {
  const GetStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          return Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAnimated(
                  tween: Tween<Offset>(
                      begin: const Offset(0, -1), end: const Offset(0, 0)),
                  curve: Curves.easeInOutCubicEmphasized,
                  duration: const Duration(seconds: 4),
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset(
                      AppImages.logo,
                      height: screenHeight * 0.2,
                      width: screenWidth * 0.5,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomAnimated(
                    beginX: 0.0,
                    beginY: 1.0,
                    curve: Curves.easeInOut,
                    duration: const Duration(seconds: 2),
                    tween: Tween<Offset>(
                      begin: const Offset(0, 1), // Slide from bottom
                      end: const Offset(0, 0), // To center
                    ),
                    alignment: Alignment.center,
                    child: TextWidget(
                      text: MyText.getStartText,
                      fSize: 16,
                      align: TextAlign.center,
                      fWeight: MyFontWeight.samiBold,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.15,
                ),
                CustomElevatedButton(
                  text: MyText.getStart,
                  gradient: AppColors.buttonGradian,
                  width: screenWidth * 0.7,
                  height: screenHeight * 0.07,
                  fontSize: Responsive.fontSize(context, 20),
                  borderRadius: 50,
                  fontWeight: MyFontWeight.samiBold,
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.login);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
