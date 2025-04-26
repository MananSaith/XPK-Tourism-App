// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:xpk/app_module/app_info/app_info_screen.dart';
import 'package:xpk/app_module/home_screen/widgets/filter_widget.dart';
import 'package:xpk/utils/imports/app_imports.dart';
import 'package:xpk/widegts/search_bar/searchBar.dart';
import '../../../main.dart';

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
              SliverToBoxAdapter(child: _buildHeader(context)),
              SliverToBoxAdapter(child: _buildFilters()),
              SliverToBoxAdapter(child: _buildPlaceList()),
            ],
          ),
          Obx(() => controller1.isPageLoad.value
              ? _buildLoadingOverlay()
              : const SizedBox()),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 135.h,
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.primaryAppBar),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
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
                    _buildPopupMenu()
                  ],
                ),
                10.sbh,
                _buildSearchBar(context)
              ],
            ),
          ),
          const Spacer(),
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
      ),
    );
  }
  Widget _buildPopupMenu() {
    return Theme(
      data: Theme.of(Get.context!).copyWith(
        cardColor: Colors.white,
        splashColor: Colors.grey[200],
        popupMenuTheme: PopupMenuThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 6,
        ),
      ),
      child: PopupMenuButton<String>(
        icon: Icon(CupertinoIcons.line_horizontal_3, color: AppColors.white),
        onSelected: (value) async {
          if (value == 'logout') {
            await FirebaseAuth.instance.signOut();
            await googleSaveBox.erase();
            Get.offAllNamed(AppRoutes.login);
          } else if (value == 'about') {
            Get.to(() => InfoAboutAppScreen());
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'logout',
            child: Row(
              children: [
                Icon(Icons.logout, color: Colors.redAccent),
                SizedBox(width: 12),
                Text(
                  'Logout',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'about',
            child: Row(
              children: [
                Icon(CupertinoIcons.info_circle, color: Colors.blueAccent),
                SizedBox(width: 12),
                Text(
                  'About App',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildSearchBar(BuildContext context) {
    return SizedBox(
      height: 33.h,
      child: CustomSearchBar(
        hintText: 'Explore Pakistan',
        controller: controller.searchController,
        leadingIcon: CupertinoIcons.search,
        lastIcon: CupertinoIcons.slider_horizontal_3,
        onIconTap: () {
          controller.isFilter.value = !controller.isFilter.value;
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
    );
  }

  Widget _buildFilters() {
    return Obx(() => controller.isFilter.value
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFilterCategory("Time Duration", controller.timeDurations, (val) {
          controller.timeDuration.value = val;
          controller.timeDuration.value != "NA"
              ? controller.timeDurationApi()
              : controller.getPlaceApi();
        }, controller.timeDuration.value),
        _buildFilterCategory("Cities", controller.pakistanCities, (val) {
          controller.city.value = val;
          if (controller.timeDuration.value != "NA") {
            showCustomSnackBar(message: "For city search Time Duration Must be NA", title: 'Alter');
          } else {
            controller.getPlaceApi();
          }
        }, controller.city.value),
        _buildFilterCategory("Categories", controller.placeCategories, (val) {
          controller.type.value = val;
          controller.timeDuration.value != "NA"
              ? controller.timeDurationApi()
              : controller.getPlaceApi();
        }, controller.type.value),
      ],
    )
        : SizedBox.shrink());
  }

  Widget _buildFilterCategory(String title, List<String> items, Function(String) onTap, String selectedItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 3),
        SizedBox(
          height: 30,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: items
                  .map((item) => buildCategoryChip(
                label: item,
                color: AppColors.cardBackground,
                onTap: () => onTap(item),
                isSelected: selectedItem == item,
              ))
                  .toList(),
            ),
          ),
        ),
        SizedBox(height: 5),
      ],
    );
  }

  Widget _buildPlaceList() {
    return Obx(() {
      if (controller.isPageLoad.value) return Center(child: customLoader(AppColors.primaryAppBar));
      if (controller.displayPlaceList.isEmpty)
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "No places found. Try a different search.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        );

      return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.displayPlaceList.length,
        itemBuilder: (context, index) {
          final place = controller.displayPlaceList[index];
          return PlaceCard(place: place);
        },
      );
    });
  }

  Widget _buildLoadingOverlay() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: AppColors.tranparentBlack,
      child: Center(child: customLoader(AppColors.primaryAppBar)),
    );
  }
}