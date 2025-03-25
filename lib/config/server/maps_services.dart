import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xpk/utils/imports/app_imports.dart';

class MapsService {
  Future<List<Map<String, dynamic>>> textSearchPlaces({
    String? query,
    String? city = "pakistan",
    String? type = "park",
  }) async {
    bool isInternet = await internetConnectivity();
    if (isInternet) {
      const String apiKey = ApiConstant.googleApikey;

      // Construct query string
      String searchQuery = "";
      if (query != null) {
        searchQuery += " $query";
      }
      if (city != null) {
        debugPrint("=========================== city $city");
        searchQuery += " in $city";
      }
      if (type != null) {
        debugPrint("=========================== type $type");

        searchQuery += " $type";
      }

      // Encode query for URL safety
      String url = "${ApiConstant.textSearchBaseUrl}"
          "?query=${Uri.encodeComponent(searchQuery)}"
          "&region=pk"
          "&key=$apiKey";
      debugPrint("=========================== url $url");

      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          return List<Map<String, dynamic>>.from(data['results'] ?? []);
        } else {
          print(
              "=================Error: ${response.statusCode} - ${response.body}");
          return [];
        }
      } catch (e) {
        print("==================Exception: $e");
        return [];
      }
    } else {
      print("================== Internet unStable");
      appToastView(title: "UnStable Ineternet");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> nearestPlaces({
    required double latitude, // Required Latitude
    required double longitude, // Required Longitude
    int radius = 3000, // Default radius in meters
    String? type = "tourist_attraction", // Default type
    String? query, // Optional search query
  }) async {
    bool isInternet = await internetConnectivity();
    if (isInternet) {
      const String apiKey = ApiConstant.googleApikey;

      // Construct URL for Nearby Search API
      String url = "${ApiConstant.nearestBaseUrl}"
          "?location=$latitude,$longitude"
          "&radius=$radius"
          "&type=$type"
          "&key=$apiKey";

      // If query is provided, add it to the URL
      if (query != null && query.isNotEmpty) {
        url += "&keyword=${Uri.encodeComponent(query)}";
      }

      debugPrint("=========================== URL: $url");

      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          return List<Map<String, dynamic>>.from(data['results'] ?? []);
        } else {
          print(
              "================= Error: ${response.statusCode} - ${response.body}");
          return [];
        }
      } catch (e) {
        print("================== Exception: $e");
        return [];
      }
    } else {
      print("================== Internet Unstable");
      appToastView(title: "Unstable Internet");
      return [];
    }
  }

  // Future<List<Map<String, dynamic>>> nearestPlaces({
  //   required double latitude, // 📍 Required Latitude
  //   required double longitude, // 📍 Required Longitude
  //   int radius = 3000, // 📏 Default radius in meters
  //   String? type = "tourist_attraction", // 🏛 Default type
  //   String? query, // 🔍 Optional search query
  // }) async {
  //   bool isInternet = await internetConnectivity();
  //   if (!isInternet) {
  //     print("================== Internet Unstable");
  //     appToastView(title: "Unstable Internet");
  //     return [];
  //   }

  //   const String apiKey = ApiConstant.googleApikey;

  //   // ✅ **Construct URL**
  //   String url = "${ApiConstant.nearestBaseUrl}?"
  //       "location=$latitude,$longitude"
  //       "&strictbounds" // 🔹 Limits results to the given area
  //       "&rankby=prominence" // 🔥 Get most famous places first
  //       "&radius=$radius"
  //       "&type=$type"
  //       "&key=$apiKey";

  //   if (query != null && query.isNotEmpty) {
  //     url += "&keyword=${Uri.encodeComponent(query)}"; // 🔍 Add search keyword
  //   }

  //   debugPrint("=========================== URL: $url");

  //   try {
  //     final response = await http.get(Uri.parse(url));

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       List<Map<String, dynamic>> results =
  //           List<Map<String, dynamic>>.from(data['results'] ?? []);

  //       print("====== Total Places Found: ${results.length}");

  //       // ✅ **Define Allowed Place Types**
  //       List<String> allowedTypes = [
  //         "tourist_attraction",
  //         "park",
  //         "museum",
  //         "landmark", // 🏛 Add More Types Here
  //         "establishment",
  //         "point_of_interest",
  //       ];

  //       // ✅ **Filter to Include Only Specific Place Types**
  //       results = results.where((place) {
  //         List<dynamic> types = place['types'] ?? [];
  //         print("✅ Checking: ${place['name']} - Types: $types");

  //         // ✅ Check if any of the allowed types exist in the place types
  //         return types.any((type) => allowedTypes.contains(type));
  //       }).toList();

  //       print("====== Filtered Places Count: ${results.length}");
  //       return results;
  //     } else {
  //       print("🛑 Error: ${response.statusCode} - ${response.body}");
  //       return [];
  //     }
  //   } catch (e) {
  //     print("================== Exception: $e");
  //     return [];
  //   }
  // }
}
