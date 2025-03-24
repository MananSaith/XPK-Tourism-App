import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xpk/app_module/home_screen/model/text_search_place_model.dart';
import 'package:xpk/utils/imports/app_imports.dart';

class DirectionsResult {
  final List<PointLatLng> polylinePoints;
  final String distanceText;
  final String durationText;
  final int distanceValue;
  final int durationValue;

  DirectionsResult({
    required this.polylinePoints,
    required this.distanceText,
    required this.durationText,
    required this.distanceValue,
    required this.durationValue,
  });
}

class MapsService {
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/place';
  static const String _directionsUrl =
      'https://maps.googleapis.com/maps/api/directions/json';

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

  // Future<List<Map<String, dynamic>>> textSearchPlaces({
  //   String? query,
  //   String? city = "Pakistan",
  //   String? type,
  //   String? nextPageToken = null, // Optional parameter for pagination
  // }) async {
  //   final controller = Get.find<HomeController>();

  //   bool isInternet = await internetConnectivity();
  //   if (isInternet) {
  //     const String apiKey = ApiConstant.googleApikey;

  //     String url;

  //     if (nextPageToken != null) {
  //       url = "${ApiConstant.textSearchBaseUrl}?"
  //           "pagetoken=$nextPageToken"
  //           "&key=$apiKey";
  //     } else {
  //       String searchQuery = query!;
  //       if (city != null) {
  //         debugPrint("=========================== city $city");
  //         searchQuery += " in $city";
  //       }
  //       if (type != null) {
  //         debugPrint("=========================== type $type");
  //         searchQuery += " $type";
  //       }

  //       url = "${ApiConstant.textSearchBaseUrl}?"
  //           "query=${Uri.encodeComponent(searchQuery)}"
  //           "&region=pk"
  //           "&key=$apiKey";
  //     }

  //     debugPrint("=========================== url $url");

  //     try {
  //       final response = await http.get(Uri.parse(url));

  //       if (response.statusCode == 200) {
  //         final data = json.decode(response.body);

  //         // Extract nextPageToken if available
  //         controller.nextPageToken = data['next_page_token'];
  //         debugPrint(
  //             "=========================== Next Page Token: ${controller.nextPageToken}");

  //         return List<Map<String, dynamic>>.from(data['results'] ?? []);
  //       } else {
  //         print(
  //             "=================Error: ${response.statusCode} - ${response.body}");
  //         return [];
  //       }
  //     } catch (e) {
  //       print("==================Exception: $e");
  //       return [];
  //     }
  //   } else {
  //     print("================== Internet unStable");
  //     appToastView(title: "UnStable Internet");
  //     return [];
  //   }
  // }

  // Get Directions
  static Future<DirectionsResult?> getDirections(
      double startLat, double startLng, double endLat, double endLng) async {
    final url =
        '$_directionsUrl?origin=$startLat,$startLng&destination=$endLat,$endLng&key=${ApiConstant.googleApikey}';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK' && data['routes'].isNotEmpty) {
          final route = data['routes'][0];
          final leg = route['legs'][0];

          final polylinePoints = PolylinePoints()
              .decodePolyline(route['overview_polyline']['points']);

          return DirectionsResult(
            polylinePoints: polylinePoints,
            distanceText: leg['distance']['text'],
            durationText: leg['duration']['text'],
            distanceValue: leg['distance']['value'],
            durationValue: leg['duration']['value'],
          );
        }
      }
    } catch (e) {
      // log('Error fetching directions: $e');
    }
    return null;
  }

  // Get current location
  static Future<Position?> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      // log('Error fetching location: $e');
      return null;
    }
  }

  // Get full place details
  static Future<TextSearchPlaceModel?> getPlaceDetails(String placeId) async {
    final url = Uri.parse(
        '$_baseUrl/details/json?place_id=$placeId&fields=name,rating,user_ratings_total,formatted_phone_number,formatted_address,geometry,photo,review,url,website,price_level,opening_hours,current_opening_hours,editorial_summary,types,permanently_closed,business_status&key=${ApiConstant.googleApikey}');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK' && data['result'] != null) {
          return TextSearchPlaceModel.fromJson(data['result']);
        }
      }
    } catch (e) {
      // log('Error fetching place details: $e');
    }
    return null;
  }

  // Search for places (fetches full details using place_id)
  static Future<List<TextSearchPlaceModel>> searchPlaces(
      String query, Position position) async {
    final searchUrl = Uri.parse(
        '$_baseUrl/textsearch/json?query=$query&location=${position.latitude},${position.longitude}&radius=50000&key=${ApiConstant.googleApikey}');

    return await _fetchFullPlaceDetailsFromSearch(searchUrl);
  }

  // Get nearby places (fetches full details using place_id)
  static Future<List<TextSearchPlaceModel>> getNearbyPlaces(
      Position position, String duration) async {
    int radius = _getRadiusFromDuration(duration);
    if (radius == -1) return await getDistantPlaces(position);

    final nearbyUrl = Uri.parse(
        '$_baseUrl/nearbysearch/json?location=${position.latitude},${position.longitude}&radius=$radius&type=tourist_attraction&key=${ApiConstant.googleApikey}');

    return await _fetchFullPlaceDetailsFromSearch(nearbyUrl);
  }

  // Get distant places (fetches full details using place_id)
  static Future<List<TextSearchPlaceModel>> getDistantPlaces(
      Position position) async {
    final distantUrl = Uri.parse(
        '$_baseUrl/textsearch/json?query=cities&location=${position.latitude},${position.longitude}&radius=300000&key=${ApiConstant.googleApikey}');

    return await _fetchFullPlaceDetailsFromSearch(distantUrl);
  }

  // Fetch places from search and get full details using place_id
  static Future<List<TextSearchPlaceModel>> _fetchFullPlaceDetailsFromSearch(
      Uri searchUrl) async {
    try {
      final response = await http.get(searchUrl);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List?;

        if (results == null || results.isEmpty) {
          throw Exception('No places found.');
        }

        // Extract placeIds from results and fetch full details
        List<String> placeIds =
            results.map((place) => place['place_id'].toString()).toList();
        return await _fetchMultiplePlaceDetails(placeIds);
      }
    } catch (e) {
      // log('Error fetching places from search: $e');
    }
    return [];
  }

  // Fetch multiple place details by placeIds using the details API
  static Future<List<TextSearchPlaceModel>> _fetchMultiplePlaceDetails(
      List<String> placeIds) async {
    List<TextSearchPlaceModel> detailedPlaces = [];
    for (String placeId in placeIds) {
      final details = await getPlaceDetails(placeId);
      if (details != null) {
        detailedPlaces.add(details);
      }
    }
    return detailedPlaces;
  }

  // Get radius from duration
  static int _getRadiusFromDuration(String duration) {
    switch (duration) {
      case '2 Hours':
      case '4 Hours':
        return 15000;
      case '8 Hours':
      case '12 Hours':
        return 35000;
      case '1 Day':
        return 50000;
      case '2 Day':
      case '3 Day':
      case '5 Day':
        return -1; // Indicates multi-day trip
      default:
        return 20000;
    }
  }

  // Get photo URL
  static String getPhotoUrl(String photoReference, {int maxWidth = 400}) {
    return '$_baseUrl/photo?maxwidth=$maxWidth&photoreference=$photoReference&key=${ApiConstant.googleApikey}';
  }

  Future<bool> internetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
