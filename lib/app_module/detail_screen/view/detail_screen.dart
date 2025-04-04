import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:xpk/app_module/detail_screen/widgets/accessories_widget.dart';
import 'package:xpk/app_module/detail_screen/widgets/address_rating_widget.dart';
import 'package:xpk/app_module/detail_screen/widgets/navigate_button_Widget.dart';
import 'package:xpk/app_module/detail_screen/widgets/page_indecator.dart';
import 'package:xpk/utils/imports/app_imports.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({super.key});
  final controller = Get.find<DetailPlaceController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.scafoldBackGroundGrandient,
        ),
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    //expandedHeight: 300.h,
                    leading: IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(
                          CupertinoIcons.back,
                          color: AppColors.white,
                        )),
                    title: AppText(
                      text: controller.detailPlaceList[0].name!,
                      size: 15.sp,
                      color: AppColors.white,
                      fontWeight: FontWeights.bold,
                    ),
                    pinned: true,
                    backgroundColor: AppColors.primaryAppBar,
                  ),
                  SliverToBoxAdapter(
                    child: AutoScrollImageSlider(
                      photoReferences: controller.detailPlaceList[0].photos!
                          .map((photo) => photo.photoReference!)
                          .toList(),
                      controllerPage: controller.controllerPage,
                    ),
                  ),
                  AddressRatingWidget(
                    address: controller.detailPlaceList[0].formattedAddress!,
                    rating: controller.detailPlaceList[0].rating!,
                    totalRating:
                        controller.detailPlaceList[0].userRatingsTotal!,
                    reviews: [
                      ...controller.detailPlaceList[0].reviews!,
                    ],
                  ),
                  Accessories(
                    origanLat:
                        controller.detailPlaceList[0].geometry!.location!.lat!,
                    origanLng:
                        controller.detailPlaceList[0].geometry!.location!.lng!,
                  ),
                  NavigateButtonWidget(
                    destinationLat:
                        controller.detailPlaceList[0].geometry!.location!.lat!,
                    destinationLng:
                        controller.detailPlaceList[0].geometry!.location!.lng!,
                    name: controller.detailPlaceList[0].name!,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
