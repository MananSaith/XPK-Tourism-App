import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:xpk/app_module/app_info/app_info_screen.dart';
import 'package:xpk/app_module/home_screen/widgets/filter_widget.dart';
import 'package:xpk/utils/imports/app_imports.dart';
import 'package:xpk/widegts/search_bar/searchBar.dart';

import 'controller/save_controller.dart';

// ignore: must_be_immutable
class SaveScreen extends StatefulWidget {
  SaveScreen({super.key});

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
TextEditingController searchController = TextEditingController();

  final controller = Get.find<SaveController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                      height: 100.h,
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

                                15.sbh,
                                SizedBox(
                                  height: 33.h,
                                  child: CustomSearchBar(
                                    hintText: 'Save Search',
                                    controller: searchController,
                                    leadingIcon: CupertinoIcons.search,


                                    textInputAction: TextInputAction.search,
                                    onChanged: (v) {
                                      setState(() {

                                      });
                                      controller.update();
                                    },
                                    onSubmit: (v) {
                                      controller.update(); // Optional
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

                // SliverToBoxAdapter(
                //   child: Obx(() => controller.googleList.isEmpty
                //       ? Center(
                //     child: Padding(
                //       padding: const EdgeInsets.all(20.0),
                //       child: Text(
                //         "No places Saved. Go and Explore",
                //         style:
                //         TextStyle(fontSize: 16, color: Colors.grey),
                //         textAlign: TextAlign.center,
                //       ),
                //     ),
                //   )
                //       : ListView.builder(
                //     padding: EdgeInsets.zero,
                //     shrinkWrap: true,
                //     physics: NeverScrollableScrollPhysics(),
                //     itemCount: controller.googleList.length,
                //     itemBuilder: (context, index) {
                //       final place = controller.googleList[index];
                //
                //       return PlaceCard(place: place);
                //     },
                //   )),
                // )

                SliverToBoxAdapter(
                  child: Obx(() {
                    final searchText = searchController.text.toLowerCase();

                    final filteredList = controller.googleList.where((place) {
                      final name = place.name?.toLowerCase() ?? '';
                      return name.contains(searchText);
                    }).toList();

                    return filteredList.isEmpty
                        ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "No places found with that name.",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                        : ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final place = filteredList[index];
                        return PlaceCard(place: place);
                      },
                    );
                  }),
                ),

              ],
            ),

          ],
        ));
  }
}
