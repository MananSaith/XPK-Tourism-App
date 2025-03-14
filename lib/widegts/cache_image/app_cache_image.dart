import 'package:get/get.dart';
import 'package:xpk/utils/imports/app_imports.dart';



// ignore: must_be_immutable
class AppCacheImageView extends StatelessWidget {
  AppCacheImageView({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.borderRadius = 10,
    this.isProfile = false,
    this.boxFit = BoxFit.contain,
  });

  final String imageUrl;
  double width = Get.width * .3;
  double height = Get.height * .3;
  double borderRadius = 10;
  bool isProfile = false;
  BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        // height: AppConfig(context).height * .04,
        height: height,
        width: width,
        fit: boxFit, //isProfile ? BoxFit.cover : BoxFit.contain,
        imageUrl: imageUrl.contains('http')
            ? imageUrl
            : HelperFunctions.getImageUrl(imageUrl),
        // imageUrl: imageUrl,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: Container(
            // width: 25,
            // height: 15,
            margin: const EdgeInsets.all(2),
            child: customLoader(
              AppColors.primaryAppBar,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Image.asset(
          AppImages.logo1,
          fit: BoxFit.cover,
          height: height,
          width: width,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AppProfileCacheImageView extends StatelessWidget {
  AppProfileCacheImageView({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.borderRadius = 100,
  });

  final String imageUrl;
  double width = Get.width * .3;
  double height = Get.height * .3;
  double borderRadius = 10;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        // height: AppConfig(context).height * .04,
        height: height,

        width: width,
        fit: BoxFit.cover,
        imageUrl: imageUrl.contains('http')
            ? imageUrl
            : HelperFunctions.getImageUrl(imageUrl),
        // imageUrl: imageUrl,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: Container(
            // width: 25,
            // height: 15,
            margin: const EdgeInsets.all(2),
            child: customLoader(
              AppColors.primaryAppBar,
            ),
          ),
        ),
        errorWidget: (context, url, error) => CircleAvatar(
          backgroundColor: AppColors.successGreen.withValues(alpha: 0.2),
          child: Image.asset(
            AppImages.logo,
            fit: BoxFit.cover,
            height: height,
            width: width,
          ),
        ),
      ),
    );
  }
}

Widget customImage(
    {required String imageUrl,
    bool isProfile = true,
    double radius = 10,
    var width = 50.0,
    var height = 70.0,
    Color? color,
    Color? borderColor,
    BoxFit fit = BoxFit.cover}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      // border: Border.all(color: borderColor ?? AppColors.WHITE_COLOR, width: 2),
      //  color: color ?? AppColors.BOTTOM_NAV_BACKGROUND,
      borderRadius: BorderRadius.circular(radius),
    ),
    child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.file(
          File(
            imageUrl,
          ),
          errorBuilder: (context, error, stackTrace) {
            return customLoader(AppColors.primaryAppBar);
          },
          fit: BoxFit.cover,
        )),
  );
}
