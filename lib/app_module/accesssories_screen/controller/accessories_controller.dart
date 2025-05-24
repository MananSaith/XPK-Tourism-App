import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:xpk/app_module/accesssories_screen/model/accessories_model.dart';
import 'package:xpk/utils/imports/app_imports.dart';

class AccessoriesController extends GetxController {
  RxBool isPageLoad = false.obs;

  RxList<AccessoriesModel> accessoriesList = <AccessoriesModel>[].obs;
  Future accessoriesApi(
      {required String access,
      required double origanLat,
      required double origanLng}) async {
    isPageLoad(true);

    try {
      List<Map<String, dynamic>> data = [];

      Position? position = await getCurrentLocation();
      if (position == null) {
        debugPrint("============= Error: Unable to fetch location.");
        appToastView(title: "Location access required.");
        isPageLoad(false);
        return [];
      }

      print(
          "====finding radius 3000 ==== lat $origanLat  long $origanLng=== type $access");
      data = await MapsService().nearestPlacesAccessories(
          latitude: origanLat,
          longitude: origanLng,
          type: access,
          query: "only $access",
          radius: 3000);

      debugPrint("=========response ${data.toString()}");
      accessoriesList.clear();
      accessoriesList.assignAll(
          data.map((data) => AccessoriesModel.fromJson(data)).toList());
      debugPrint("========= lenght ${accessoriesList.length}");
    } catch (e) {
      debugPrint("================= error $e");
    }
    isPageLoad(false);
  }

  Future googlenavigateApi(
      {required double destinationLat, required double destinationLng}) async {
    isPageLoad(true);

    try {
      Position? position = await getCurrentLocation();
      if (position == null) {
        debugPrint("============= Error: Unable to fetch location.");
        appToastView(title: "Location access required.");
        isPageLoad(false);

        return 0;
      }

      print(
          " Origan === >>> lat ${destinationLat.toString()}  long ${destinationLng.toString()} ---- Destination ===>>>lat ${position.latitude.toString()}  long ${position.longitude.toString()} ");
      await MapsService().navigateToGoogleMaps(
        originLat: position.latitude,
        originLng: position.longitude,
        destinationLat: destinationLat,
        destinationLng: destinationLng,
      );
    } catch (e) {
      debugPrint("================= error $e");
    }
    isPageLoad(false);
  }
}
