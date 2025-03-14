
import 'package:get/get.dart';
import 'package:xpk/utils/imports/app_imports.dart';

SnackbarController appSnackBar({
  required String tileText,
  required String descriptionText,
  SnackPosition snackPosition = SnackPosition.BOTTOM,
  int duration = 2,
  Color textColor = Colors.white,
  Color backgroundColor = const Color(0xff2B3EA8),
}) {
  return Get.snackbar(
    tileText,
    descriptionText,
    snackPosition: snackPosition,
    duration: Duration(seconds: duration),
    colorText: textColor,
    backgroundColor: backgroundColor,
  );
}

customToastView({
  required String title,
}) {
  if (title.toLowerCase().contains("Validation error".toLowerCase())) {
    return;
  }
  FocusManager.instance.primaryFocus?.unfocus();
  return Fluttertoast.showToast(
      msg: title.capitalizeFirst.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.primaryAppBar,
      textColor: AppColors.whiteBar,
      fontSize: 16.0);
}

appToastView({required String title}) {
  return Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.primaryAppBar,
      textColor: AppColors.whiteBar,
      fontSize: 16.0);
}
