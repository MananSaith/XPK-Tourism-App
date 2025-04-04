import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:xpk/app_module/accesssories_screen/controller/accessories_controller.dart';
import 'package:xpk/utils/imports/app_imports.dart';

class AccessoriesScreensUi extends StatefulWidget {
  final String label;
  final double origanLat;
  final double origanLng;
  AccessoriesScreensUi(
      {super.key,
      required this.label,
      required this.origanLat,
      required this.origanLng});

  @override
  State<AccessoriesScreensUi> createState() => _AccessoriesScreensUiState();
}

class _AccessoriesScreensUiState extends State<AccessoriesScreensUi> {
  final controller = Get.put(AccessoriesController());

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await controller.accessoriesApi(
        access: widget.label.toLowerCase(),
        origanLat: widget.origanLat,
        origanLng: widget.origanLng);
    controller.accessoriesList.refresh(); // ✅ Ensure list updates properly
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: AppText(text: widget.label, color: Colors.white, size: 18.sp),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            CupertinoIcons.back,
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.primaryAppBar,
        elevation: 0,
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isPageLoad.value) {
            return Center(child: customLoader(AppColors.primaryAppBar));
          }
          if (controller.accessoriesList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off,
                      size: 50, color: AppColors.primaryAppBar),
                  SizedBox(height: 10),
                  AppText(
                      text: "No ${widget.label} found",
                      color: AppColors.primaryAppBar,
                      size: 18.sp),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: controller.accessoriesList.length,
            itemBuilder: (context, index) {
              var item = controller.accessoriesList[index];
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: (item.photos != null &&
                          item.photos!.isNotEmpty &&
                          item.photos![0].photoReference != null)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            _getPhotoUrl(item.photos![0].photoReference!),
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.broken_image,
                                  size: 60, color: Colors.grey);
                            },
                          ),
                        )
                      : Icon(Icons.image_not_supported,
                          size: 60, color: Colors.grey),
                  title: Text(item.name ?? "No Name",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.formattedAddress ?? "No Address Available",
                          style: TextStyle(color: Colors.grey[700])),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text(item.rating?.toString() ?? "N/A"),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(Icons.access_time,
                                    color: Colors.green, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  item.openingHours?.openNow == true
                                      ? "Open Now"
                                      : item.openingHours?.openNow == false
                                          ? "Closed"
                                          : "Not Available",
                                  style: TextStyle(
                                      color: item.openingHours?.openNow == true
                                          ? Colors.green
                                          : Colors.red),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              print('Container tapped');
                              await controller.googlenavigateApi(
                                destinationLat: item.geometry!.location!.lat!,
                                destinationLng: item.geometry!.location!.lng!,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primaryAppBar,
                                    Colors.blueAccent
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      'Move',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Icon(
                                      size: 15.sp,
                                      CupertinoIcons.forward,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  String _getPhotoUrl(String photoReference) {
    const String apiKey = ApiConstant.googleApikey;
    return 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=500&photo_reference=$photoReference&key=$apiKey';
  }
}
