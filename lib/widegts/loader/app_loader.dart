
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:xpk/utils/imports/app_imports.dart';

appLoader(BuildContext context, var myColors) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            content: SizedBox(
              height: 100,
              width: 100,
              child: SpinKitThreeBounce(
                color: myColors,
                size: 50.0,
              ),
            ),
          ));
}

Widget customLoader(var loadingColor) {
  return SizedBox(
    child: SpinKitThreeBounce(
      color: loadingColor,
      size: Get.height * 0.03,
    ),
  );
}
