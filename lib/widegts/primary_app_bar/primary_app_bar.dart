import 'package:get/get.dart';
import 'package:xpk/utils/imports/app_imports.dart';

// ignore: must_be_immutable
class PrimaryAppBar extends StatefulWidget {
  Color appbarColor;
  bool isPrefix;
  String title;
  VoidCallback? prefixTap;
  bool isSuffix;
  bool isCenter;
  Widget centerWidget;
  Widget suffixWidget;
  bool isBack;
  bool isTitle;
  bool isLogo;
  bool isSkip;

  VoidCallback? surffixTap;
  VoidCallback? menuTap;
  PrimaryAppBar({
    this.appbarColor = Colors.transparent,
    this.isBack = false,
    this.isSkip = false,
    this.isPrefix = false,
    this.isSuffix = false,
    this.isCenter = false,
    this.centerWidget = const SizedBox(),
    this.suffixWidget = const SizedBox(),
    this.isLogo = true,
    this.isTitle = true,
    this.title = '',
    this.prefixTap,
    this.menuTap,
    this.surffixTap,
    super.key,
  });

  @override
  State<PrimaryAppBar> createState() => _PrimaryAppBarState();
}

class _PrimaryAppBarState extends State<PrimaryAppBar> {
  @override
  Widget build(BuildContext context) {
    // final dashboardViewController = DashboardViewController.instance;
    // final homeController = HomeController.instance;
    return Container(
      color: widget.appbarColor,
      height: Get.height / 8.12,
      width: Get.width,
      child: Stack(
        children: [
          // Obx(() =>
          widget.isCenter
              ? Positioned(left: 50, top: 30, child: widget.centerWidget)
              : const SizedBox.shrink(),
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              vSizedBox(height: Get.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      widget.isPrefix
                          ? GestureDetector(
                              onTap: widget.prefixTap,
                              child: Container(
                                height: Get.height * 0.07,
                                width: Get.height * 0.06,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color:Colors.transparent,
                                  borderRadius:
                                      AppBorderRadius.BORDER_RADIUS_05,
                                ),
                                child: widget.isBack ? Icon(Icons.arrow_back_ios_new, color: AppColors.white,) : widget.isSkip ? Icon(Icons.skip_next, color: AppColors.white,) : Icon(Icons.menu, color: AppColors.white,),
                              ),
                            )
                          : Container(),
                      widget.isTitle
                          ? hSizedBox(width: 10)
                          : const SizedBox.shrink(),
                      widget.isTitle
                          ? AppText(
                              text: widget.title,
                              fontWeight: FontWeight.w600,
                              size: AppDimensions.FONT_SIZE_18,
                              color: AppColors.white,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  widget.isSuffix ? widget.suffixWidget : Container(),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
