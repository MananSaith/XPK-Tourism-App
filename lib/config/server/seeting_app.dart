// Get current location
import 'package:geolocator/geolocator.dart';
import 'package:xpk/utils/imports/app_imports.dart';

Future<Position?> getCurrentLocation() async {


  try {
    // Step 1: Check if GPS is enabled
    bool isGPSEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isGPSEnabled) {
      print('⚠ GPS is OFF. Asking user to turn it ON...');

      // Open location settings
      await Geolocator.openLocationSettings();

      // Wait and re-check if GPS is enabled
      await Future.delayed(Duration(seconds: 10));
      if (!await Geolocator.isLocationServiceEnabled()) {
        print('❌ User did not enable GPS.');
        return null;
      }
    }

    // Step 2: Check and request location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      print('⚠ Location permission denied. Requesting permission...');
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        print('❌ User denied location permission.');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('⛔ Location permission is permanently denied.');
      return null;
    }

    // Step 3: Get user location (lat/lng)
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    // Print Latitude and Longitude
    print('✅ Latitude: ${position.latitude}, Longitude: ${position.longitude}');

    return position;
  } catch (e) {
    print('⚠ Error fetching location: $e');
    return null;
  }
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
