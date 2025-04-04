import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:xpk/app_module/app_info/app_info_screen.dart';
import 'package:xpk/app_module/home_screen/widgets/filter_widget.dart';
import 'package:xpk/utils/imports/app_imports.dart';
import 'package:xpk/widegts/search_bar/searchBar.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.find<HomeController>();
  final controller1 = Get.find<DetailPlaceController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                  height: 135.h,
                  width: double.infinity,
                  decoration: BoxDecoration(color: AppColors.primaryAppBar),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 35, left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  text: 'XPkistan',
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                  size: 20.sp,
                                ),
                                IconButton(
                                    onPressed: () {
                                      Get.to(() => InfoAboutAppScreen());
                                    },
                                    icon: Icon(
                                      CupertinoIcons.info_circle,
                                      color: AppColors.white,
                                    )),
                              ],
                            ),
                            10.sbh,
                            SizedBox(
                              height: 33.h,
                              child: CustomSearchBar(
                                hintText: 'Explore Pakistan',
                                controller: controller.searchController,
                                leadingIcon: CupertinoIcons.search,
                                lastIcon: CupertinoIcons.slider_horizontal_3,
                                // isReadOnly: true,
                                onIconTap: () {
                                  controller.isFilter.value =
                                      !controller.isFilter.value;
                                },
                                textInputAction: TextInputAction.search,
                                onSubmit: (v) {
                                  FocusScope.of(context).unfocus();
                                  if (controller.timeDuration.value != "NA") {
                                    controller.timeDurationApi();
                                  } else {
                                    controller.getPlaceApi();
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      const Spacer(flex: 1),
                      Container(
                        width: double.infinity,
                        height: 10.h,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            SliverToBoxAdapter(
                child: Obx(
              () => controller.isFilter.value == false
                  ? SizedBox.shrink()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// **Time**
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "Time Duration",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 3),
                        SizedBox(
                          height: 30,
                          child: Obx(() => SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: controller.timeDurations
                                      .map((time) => buildCategoryChip(
                                            label: time,
                                            color: AppColors.cardBackground,
                                            onTap: () {
                                              controller.timeDuration.value =
                                                  time;
                                              if (controller
                                                      .timeDuration.value !=
                                                  "NA") {
                                                controller.timeDurationApi();
                                              } else {
                                                controller.getPlaceApi();
                                              }
                                            }, // Set selected city
                                            isSelected:
                                                controller.timeDuration.value ==
                                                    time,
                                          ))
                                      .toList(),
                                ),
                              )),
                        ),

                        SizedBox(height: 5),

                        /// **Cities Row**
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "Cities",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 3),
                        SizedBox(
                          height: 30,
                          child: Obx(() => SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: controller.pakistanCities
                                      .map((city) => buildCategoryChip(
                                            label: city,
                                            color: AppColors.cardBackground,
                                            onTap: () {
                                              controller.city.value = city;
                                              if (controller
                                                      .timeDuration.value !=
                                                  "NA") {
                                                showCustomSnackBar(
                                                    message:
                                                        "For city search Time Duration Must be NA",
                                                    title: 'Alter');
                                              } else {
                                                controller.getPlaceApi();
                                              }
                                            }, // Set selected city
                                            isSelected:
                                                controller.city.value == city,
                                          ))
                                      .toList(),
                                ),
                              )),
                        ),

                        SizedBox(height: 5),

                        /// **Categories Row**
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "Categories",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 3),
                        SizedBox(
                          height: 30,
                          child: Obx(() => SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: controller.placeCategories
                                      .map((category) => buildCategoryChip(
                                            label: category,
                                            color: AppColors.cardBackground,
                                            onTap: () {
                                              controller.type.value = category;
                                              if (controller
                                                      .timeDuration.value !=
                                                  "NA") {
                                                controller.timeDurationApi();
                                              } else {
                                                controller.getPlaceApi();
                                              }
                                            }, // Set selected type
                                            isSelected: controller.type.value ==
                                                category,
                                          ))
                                      .toList(),
                                ),
                              )),
                        ),
                        SizedBox(height: 3),
                      ],
                    ),
            )),
            SliverToBoxAdapter(
              child: Obx(() => controller.isPageLoad.value
                  ? Center(child: customLoader(AppColors.primaryAppBar))
                  : controller.displayPlaceList.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "No places found. Try a different search.",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.displayPlaceList.length,
                          itemBuilder: (context, index) {
                            final place = controller.displayPlaceList[index];
                            return PlaceCard(place: place);
                          },
                        )),
            )
          ],
        ),
        Obx(
          () => controller1.isPageLoad.value
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: AppColors.tranparentBlack,
                  child: Center(child: customLoader(AppColors.primaryAppBar)),
                )
              : const SizedBox(),
        ),
      ],
    ));
  }
}
