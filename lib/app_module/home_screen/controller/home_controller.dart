import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:xpk/app_module/home_screen/model/text_search_place_model.dart';
import 'package:xpk/utils/imports/app_imports.dart';

class HomeController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  RxBool isPageLoad = false.obs;
  RxBool isFilter = false.obs;
  RxString timeDuration = "NA".obs;
  RxString city = "Pakistan".obs;
  RxString type = "Park".obs;

  RxList<TextSearchPlaceModel> displayPlaceList = <TextSearchPlaceModel>[].obs;

  @override
  void onInit() {
    getCurrentLocation();
    getPlaceApi();
    super.onInit();
  }

  void getPlaceApi() async {
    isPageLoad(true);
    displayPlaceList.clear();

    try {
      List<Map<String, dynamic>> data =
          []; //= await MapsService().textSearchPlaces();

      if (searchController.text.isNotEmpty) {
        data = await MapsService().textSearchPlaces(
            query: searchController.text,
            city: this.city.value,
            type: this.type.value);
      } else {
        print(
            "=============== city ${this.city.value} ========== type ${this.type.value}");
        data = await MapsService()
            .textSearchPlaces(city: this.city.value, type: this.type.value);
      }

      debugPrint("=========response ${data.toString()}");
      displayPlaceList.assignAll(
          data.map((data) => TextSearchPlaceModel.fromJson(data)).toList());
      searchController.clear();
      debugPrint("========= lenght ${displayPlaceList.length}");
    } catch (e) {
      debugPrint("================= error $e");
    }
    isPageLoad(false);
  }

  void timeDurationApi() async {
    isPageLoad(true);

    try {
      List<Map<String, dynamic>> data = [];
      if (timeDuration.value == "NA") {
        isPageLoad(false);
        return;
      }
      int radius = getDistanceForTime(timeDuration.value);
      Position? position = await getCurrentLocation();
      if (position == null) {
        debugPrint("============= Error: Unable to fetch location.");
        appToastView(title: "Location access required.");
        isPageLoad(false);
        return; // Stop execution if location is null
      }

      if (searchController.text.isNotEmpty) {
        data = await MapsService().nearestPlaces(
           // query: searchController.text,
            latitude: position.latitude,
            longitude: position.longitude,
            //type: this.type.value,
            radius: radius);
      } else {
        print(
            "==== radius $radius ==== lat ${position.latitude.toString()}  long ${position.longitude.toString()} === type ${this.type.value}");
        data = await MapsService().nearestPlaces(
            latitude: position.latitude,
            longitude: position.longitude,
           // type: this.type.value,
            radius: radius);
      }

      debugPrint("=========response ${data.toString()}");
      displayPlaceList.clear();
      displayPlaceList.assignAll(
          data.map((data) => TextSearchPlaceModel.fromJson(data)).toList());
      searchController.clear();
      debugPrint("========= lenght ${displayPlaceList.length}");
    } catch (e) {
      debugPrint("================= error $e");
    }
    isPageLoad(false);
  }

  List<String> placeCategories = [
    "Park",
    "Historical",
    "Beach",
    "Museum",
    "Mountain",
    "Lake",
    "Waterfall",
    "Garden",
    "Zoo",
    "Temple",
    "Mosque",
    "Church",
    "Shopping Mall",
    "Food Street",
    "Wildlife Sanctuary",
    "Cultural Center",
    "Art Gallery",
    "Bridge",
    "Library",
    "Stadium",
    "Fort",
    "Palace",
    "National Park",
    "Desert",
    "Island",
    "Cave",
    "Amusement Park",
    "Market",
    "Monument",
    "River",
    "Aquarium"
  ];
  List<String> pakistanCities = [
    "Pakistan",
    "Lahore",
    "Karachi",
    "Islamabad",
    "Rawalpindi",
    "Faisalabad",
    "Multan",
    "Peshawar",
    "Quetta",
    "Sialkot",
    "Gujranwala",
    "Hyderabad",
    "Bahawalpur",
    "Sargodha",
    "Sukkur",
    "Larkana",
    "Sheikhupura",
    "Jhang",
    "Mardan",
    "Gujrat",
    "Abbottabad",
    "Muzaffarabad",
    "Mirpur",
    "Dera Ghazi Khan",
    "Chiniot",
    "Okara",
    "Kasur",
    "Nawabshah",
    "Mingora",
    "Sahiwal",
    "Rahim Yar Khan",
    "Khuzdar",
    "Kotli",
    "Dera Ismail Khan",
    "Mansehra",
    "Gwadar"
  ];
  List<String> timeDurations = [
    "NA",
    "2 Hours",
    "4 Hours",
    "6 Hours",
    "8 Hours",
    // "2 Day",
    // "3 Days",
    // "5 Days",
  ];

  int getDistanceForTime(String duration) {
    switch (duration) {
      case "2 Hours":
        return 5000;
      case "4 Hours":
        return 8000;
      case "6 Hours":
        return 12000;
      case "8 Hours":
        return 16000;
      // case "2 Day":
      //   return 50000;
      // case "3 Days":
      //   return 80000;
      // case "5 Days":
      //   return 120000;
      default:
        return 0;
    }
  }
}
