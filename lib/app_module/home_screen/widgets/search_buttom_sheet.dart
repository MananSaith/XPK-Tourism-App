import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:xpk/utils/imports/app_imports.dart';

Future<Map<String, dynamic>?> showPlaceSearchBottomSheet() async {
  final controller = Get.find<HomeController>();

  return await Get.bottomSheet<Map<String, dynamic>>(
    Container(
      height: Get.height * 0.7,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          // 🏷️ **Header Title**
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Search Places",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              IconButton(
                icon: Icon(Icons.close, size: 24, color: Colors.grey),
                onPressed: () => Get.back(),
              ),
            ],
          ),
          SizedBox(height: 10),

          // **Search Field**
          GooglePlaceAutoCompleteTextField(
            textEditingController: controller.searchController,
            googleAPIKey: ApiConstant.googleApikey,
            inputDecoration: InputDecoration(
              hintText: "Search for a place...",
              hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 16),
              filled: true,
              fillColor: Colors.grey.shade200,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 14, horizontal: 16),

              // ✅ REMOVE ALL BORDERS
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none, // ✅ No border
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none, // ✅ No border
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none, // ✅ No border
              ),

              prefixIcon: Icon(CupertinoIcons.search, color: Colors.blueAccent),
              suffixIcon: IconButton(
                icon: Icon(CupertinoIcons.clear, color: Colors.redAccent),
                onPressed: () {
                  controller.searchController.clear();
                },
              ),
            ),

            isCrossBtnShown: false,
            debounceTime: 800,
            countries: ["pk"],
            isLatLngRequired: true,
            getPlaceDetailWithLatLng: (Prediction prediction) {
              print("placeDetails" + prediction.lng.toString());
            },
            itemClick: (Prediction prediction) {
              controller.searchController.text = prediction.description!;
              controller.searchController.selection =
                  TextSelection.fromPosition(
                TextPosition(offset: prediction.description!.length),
              );
              Get.back();
            },

            // **Make the suggestion list scrollable**
            itemBuilder: (context, index, Prediction prediction) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.1),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue.withOpacity(0.1),
                      ),
                      child: Icon(Icons.location_on,
                          color: Colors.blueAccent, size: 24),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            prediction.description ?? "Unknown Location",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            prediction.structuredFormatting?.secondaryText ??
                                "Tap to select",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },

            seperatedBuilder: Divider(),
            placeType: PlaceType.establishment,
          ),

          // **SizedBox to give space for scrolling results**
          SizedBox(height: 10),

          // **Expanded widget to make the list scrollable**
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: Get.height * 0.5), // Adjust as needed
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}
