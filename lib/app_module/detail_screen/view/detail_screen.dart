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
        child: Obx(() {
          if (controller.detailPlaceList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final place = controller.detailPlaceList[0];

          return Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      leading: IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(
                          CupertinoIcons.back,
                          color: AppColors.white,
                        ),
                      ),
                      title: AppText(
                        text: place.name ?? 'Unknown Place',
                        size: 15.sp,
                        color: AppColors.white,
                        fontWeight: FontWeights.bold,
                      ),
                      pinned: true,
                      backgroundColor: AppColors.primaryAppBar,
                    ),
                    SliverToBoxAdapter(
                      child: AutoScrollImageSlider(
                        photoReferences: place.photos
                            ?.map((photo) => photo.photoReference ?? '')
                            .where((ref) => ref.isNotEmpty)
                            .toList() ??
                            [],
                        controllerPage: controller.controllerPage,
                      ),
                    ),
                    AddressRatingWidget(
                      address: place.formattedAddress ?? "No Address",
                      rating: place.rating ?? 0.0,
                      totalRating: place.userRatingsTotal ?? 0,
                      reviews: place.reviews ?? [],
                    ),
                    Accessories(
                      origanLat: place.geometry?.location?.lat ?? 0.0,
                      origanLng: place.geometry?.location?.lng ?? 0.0,
                    ),
                    NavigateButtonWidget(
                      destinationLat: place.geometry?.location?.lat ?? 0.0,
                      destinationLng: place.geometry?.location?.lng ?? 0.0,
                      name: place.name ?? "Unknown",
                    )
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

}
