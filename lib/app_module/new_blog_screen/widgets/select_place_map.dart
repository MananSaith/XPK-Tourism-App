import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:xpk/app_module/new_blog_screen/controller/new_blog_controller.dart';
import 'package:xpk/utils/constant/api_constant.dart';

class FullScreenMapSearch extends StatefulWidget {
  @override
  _FullScreenMapSearchState createState() => _FullScreenMapSearchState();
}

class _FullScreenMapSearchState extends State<FullScreenMapSearch> {
  final NewBlogController controller = Get.find<NewBlogController>();

  late GoogleMapController mapController;
  final TextEditingController _searchController = TextEditingController();

  LatLng _selectedLatLng = LatLng(31.5204, 74.3587); // Default: Lahore
  String _selectedPlaceName = "";
  final String googleApiKey = ApiConstant.googleApikey;
  bool _isSearching = false; 

  void _onCameraMove(CameraPosition position) {
    _selectedLatLng = position.target;
  }

  Future<void> _updatePlaceFromLatLng() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      _selectedLatLng.latitude,
      _selectedLatLng.longitude,
    );

    controller.destinationLat = _selectedLatLng.latitude.toString();
    controller.destinationLng = _selectedLatLng.longitude.toString();

    if (placemarks.isNotEmpty) {
      final place = placemarks.first;
      setState(() {
        _selectedPlaceName =
            "${place.name ?? ''}, ${place.locality ?? ''}, ${place.country ?? ''}";
        controller.LocationController.text = _selectedPlaceName;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _selectedLatLng = LatLng(position.latitude, position.longitude);
    });

    if (mapController != null) {
      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(_selectedLatLng, 14),
      );
    }

    await _updatePlaceFromLatLng(); // Update place name at bottom
  }

  void _goToLocation(double lat, double lng, String desc) {
    setState(() {
      print("======================= Selected: $lat, $lng, $desc");
      _selectedLatLng = LatLng(lat, lng);
      _selectedPlaceName = desc;
      _searchController.text = desc;
      _isSearching = false;

      controller.LocationController.text = desc;
      controller.destinationLat = lat.toString();
      controller.destinationLng = lng.toString();

      print("=============================== end");
    });

    mapController.animateCamera(CameraUpdate.newLatLng(_selectedLatLng));
    _updatePlaceFromLatLng(); // Update place name after marker move
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => mapController = controller,
            initialCameraPosition: CameraPosition(
              target: _selectedLatLng,
              zoom: 14,
            ),
            onCameraMove: _onCameraMove,
            onCameraIdle: _updatePlaceFromLatLng,
            markers: {
              Marker(
                markerId: MarkerId("selected"),
                position: _selectedLatLng,
              ),
            },
          ),
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(25),
              child: GooglePlaceAutoCompleteTextField(
                textEditingController: _searchController,
                googleAPIKey: googleApiKey,

                inputDecoration: InputDecoration(
                  hintText: "Search place...",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
                debounceTime: 400,
                isLatLngRequired: true,
                boxDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                getPlaceDetailWithLatLng: (Prediction prediction) {
                  print("placeDetails" + prediction.lng.toString());
                },
                countries: ["pk"],

                itemClick: (Prediction prediction) async {
                  print(
                      "======================= Selected: ${prediction.description}");

                  _searchController.text = prediction.description ?? "";

                  try {
                    List<Location> locations =
                        await locationFromAddress(prediction.description!);
                    if (locations.isNotEmpty) {
                      final loc = locations.first;
                      _goToLocation(
                          loc.latitude, loc.longitude, prediction.description!);
                    } else {
                      print("No coordinates found for this place.");
                    }
                  } catch (e) {
                    print("Error converting address to lat/lng: $e");
                  }

                  FocusScope.of(context)
                      .unfocus(); // Hide keyboard and remove focus
                },

                seperatedBuilder: Divider(),
                itemBuilder: (context, index, Prediction prediction) {
                  return ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(prediction.description ?? ""),
                  );
                },
                containerHorizontalPadding: 10,
                //enabled: _isSearching, // Only allow search if searching
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _selectedPlaceName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Lat: ${_selectedLatLng.latitude}, Lng: ${_selectedLatLng.longitude}",
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: IconButton(onPressed: ()=>Get.back(), icon: Icon(CupertinoIcons.check_mark,
                      size: 20,
                      color: CupertinoColors.activeGreen,)),
                  )
                ],
              ),
            ),
          ),
          Center(
            child: Icon(
              Icons.location_pin,
              size: 40,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
