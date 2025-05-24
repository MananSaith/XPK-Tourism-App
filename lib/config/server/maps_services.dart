import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
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
      debugPrint("====== url TextSearch: $url");

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
    required double latitude,
    required double longitude,
    int radius = 3000,
  }) async {
    bool isInternet = await internetConnectivity();
    if (!isInternet) {
      print("Internet Unstable");
      appToastView(title: "Unstable Internet");
      return [];
    }

    const String apiKey = ApiConstant.googleApikey;

    // 🎯 Multi-type keywords with OR logic
    String keywords = "tourist attraction OR park OR zoo OR museum OR art gallery OR amusement park";

    String url = "${ApiConstant.nearestBaseUrl}"
        "?location=$latitude,$longitude"
        "&radius=$radius"
        "&keyword=${Uri.encodeComponent(keywords)}"
        "&key=$apiKey";

    debugPrint("🎯 NEAREST TOURISM URL: $url");

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = List<Map<String, dynamic>>.from(data['results'] ?? []);

        debugPrint("✅ Raw Results: ${results.length}");

        // 🛑 Only allow these types
        final allowedTypes = [
          'tourist_attraction',
          'museum',
          'park',
          'zoo',
          'art_gallery',
          'amusement_park',
        ];

        final filteredResults = results.where((place) {
          final types = List<String>.from(place['types'] ?? []);
          final hasPlaceId = place.containsKey('place_id');
          final isRelevant = types.any((type) => allowedTypes.contains(type));
          final hasImage = place.containsKey('photos') && (place['photos'] as List).isNotEmpty;

          return hasPlaceId && isRelevant && hasImage;
        }).toList();

        debugPrint("✅ Filtered Places Found: ${filteredResults.length}");

        return filteredResults;
      } else {
        print("❌ Error: ${response.statusCode} - ${response.body}");
        return [];
      }
    } catch (e) {
      print("❌ Exception: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> nearestPlacesAccessories({
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

      debugPrint("===== URL Nearest Api: $url");

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



// Function to launch Google Maps navigation
Future<void> navigateToGoogleMaps({
  required double originLat,
  required double originLng,
  required double destinationLat,
  required double destinationLng,
}) async {
  final googleMapsUrl = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&origin=$originLat,$originLng&destination=$destinationLat,$destinationLng&travelmode=driving');

  if (await canLaunchUrl(googleMapsUrl)) {
    await launchUrl(googleMapsUrl);
  } else {
    throw 'Could not launch Google Maps';
  }
}



  Future<Map<String, dynamic>?> fetchDistanceAndDuration(
    double originLat, double originLng, double destLat, double destLng) async {
  const String apiKey = ApiConstant.googleApikey;
  
  String url = "https://maps.googleapis.com/maps/api/distancematrix/json"
      "?origins=$originLat,$originLng"
      "&destinations=$destLat,$destLng"
      "&key=$apiKey";

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      
      if (data["status"] == "OK" && data["rows"].isNotEmpty) {
        var elements = data["rows"][0]["elements"][0];

        return {
          "distance": elements["distance"]["text"],
          "duration": elements["duration"]["text"],
        };
      }
    }
  } catch (e) {
    print("Error fetching distance/time: $e");
  }
  return null;
}


  Future<Map<String, dynamic>> detailAboutPlace({
    required String placeId,
  }) async {
    bool isInternet = await internetConnectivity();
    if (isInternet) {
      const String apiKey = ApiConstant.googleApikey;

      String url = "${ApiConstant.detailAboitBaseUrl}?"
          "place_id=$placeId"
          "&key=$apiKey";

      debugPrint("===== URL Deatil Api: $url");

      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          print("============== response main ${data['result']}");
        
          return data['result'];
        } else {
          print("Error: ${response.statusCode} - ${response.body}");
          return {};
        }
      } catch (e) {
        print("Exception: $e");
        return {};
      }
    } else {
      print("Internet Unstable");
      appToastView(title: "Unstable Internet");
      return {};
    }
  }
}
