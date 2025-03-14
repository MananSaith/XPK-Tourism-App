import 'package:get/get.dart';
import 'package:xpk/utils/imports/app_imports.dart';

// ignore: must_be_immutable
class GalleryCameraBottomSheet extends StatelessWidget {
  bool isProofScreen;
  bool isLicenseFront;
  bool isLicenseBack;
  GalleryCameraBottomSheet({
    super.key,
    this.isProofScreen = false,
    this.isLicenseFront = false,
    this.isLicenseBack = false,
  });

  ImagePicker imagePicker = ImagePicker();

  Future addImage({
    ImageSource? source,
  }) async {
    final pickImage =
        await imagePicker.pickImage(source: source!, imageQuality: 100);
    if (pickImage == null) return;

    // ignore: unused_local_variable
    final pickedImage = File(pickImage.path);

    //authController.setImagePath = pickedImage.path;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: Get.height * 0.015),
            AppText(
                text: 'Please Choose One',
                size: AppDimensions.FONT_SIZE_18,
                fontWeight: FontWeight.w600),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                      addImage(source: ImageSource.camera);
                    },
                    child: Container(
                      width: Get.width * 0.25,
                      height: Get.width * 0.25,
                      decoration: BoxDecoration(
                          color: AppColors.primaryAppBar,
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        Icons.camera_alt,
                        size: AppDimensions.FONT_SIZE_50,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();

                      addImage(source: ImageSource.gallery);
                    },
                    child: Container(
                      width: Get.width * 0.25,
                      height: Get.width * 0.25,
                      decoration: BoxDecoration(
                          color: AppColors.primaryAppBar,
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        Icons.photo,
                        size: AppDimensions.FONT_SIZE_50,
                        color: AppColors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
